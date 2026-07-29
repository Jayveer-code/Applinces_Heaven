"""
ElectroBot — Gemini-powered AI Shopping & Support Assistant
for Appliances Heaven
"""

import json
import google.generativeai as genai
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
from django.shortcuts import render
from django.conf import settings
from store.models import Product, Categories

# ─── Configure Gemini ────────────────────────────────────────────────────────
GEMINI_API_KEY = getattr(settings, 'GEMINI_API_KEY', 'YOUR_GEMINI_API_KEY_HERE')
genai.configure(api_key=GEMINI_API_KEY)

# ─── System Prompt ────────────────────────────────────────────────────────────
ELECTROBOT_SYSTEM_PROMPT = """
**Role**: You are "ElectroBot," the elite AI Shopping & Support Assistant for Appliances Heaven — India's premier home appliances e-commerce store. You specialize in home appliances (ACs, Refrigerators, Washing Machines, TVs, Mobiles, Kitchen Appliances, etc.).

**Store Info**: Appliances Heaven sells a wide range of electrical appliances. All prices are in Indian Rupees (₹). Deliveries are pan-India.

**Core Objectives**:
1. **Guide the Journey**: Assist users from product discovery to troubleshoot.
2. **Contextual Precision**: Use the search_inventory tool to find real products from our database. Never hallucinate or invent products not in the database.
3. **Troubleshoot First**: For appliance issues, provide a 3-step safety/fix guide before suggesting a replacement or service.
4. **Smart Upselling**: When a user picks a budget item, suggest a slight upgrade with a "Pro-Tip."

**Response Style**:
- **Tone**: Professional, energetic, friendly, and concise. Use emojis tastefully (⚡🛒✅❄️🔥).
- **Formatting**: Use bullet points for product lists. **Bold** the product names.
- **Recommendations**: When asked for a recommendation, always try to provide up to 3 options labeled as 🏷️ Budget, 🏆 Best Seller, 💎 Premium.
- **Comparison**: Use a Markdown table when comparing 2 or more products.
- **Language**: Respond in the SAME language the user writes in. If they write in Hindi (Hinglish), respond in Hinglish. If English, respond in English.

**Handling Logic**:
- **Vague Query** (e.g., "I need an AC"): Always ask 2 clarifying questions: "What is your **room size**?" and "What is your **approximate budget**?"
- **Appliance Issue** (e.g., "Fridge not cooling"): Start with "I'm sorry you're facing this! Let's try to fix it! 🔧" then list troubleshooting steps.
- **Product Missing**: Say "I don't have that exact model in my current catalog, but here is the closest match based on your needs."
- **Price queries**: Always include ₹ symbol, star ratings, and key features.

**Troubleshooting Flow**:
When a user reports a malfunction:
1. Identify the appliance type.
2. Provide the top 3 common non-technical fixes (e.g., "Check the power plug", "Clean the filter", "Check the door seal").
3. Always remind: "⚠️ Please **unplug the appliance** before inspecting."
4. If issue persists, advise them to contact Appliances Heaven support.

**Safety Rule**: Never provide electrical repair advice that requires opening a machine or touching bare wires. Always advise unplugging first.

**Smart Upsell**: Whenever a user selects a Budget item, add at the bottom:
💡 **Pro-Tip**: "For just ₹[X] more, the [Premium Model] offers [key feature] which saves more electricity / lasts longer."

**Tool Usage**:
You have access to `search_inventory`. Use it to get real product data:
- Always correct spelling mistakes in the user's query before searching (e.g., if user says "iphoe", pass "iphone").
- If user mentions price (e.g., "under ₹30,000"), use max_price parameter.
- If user mentions a category (e.g., "refrigerator", "AC"), pass it as category.
- Always show ratings with ⭐ symbols.
- Show the product URL as a clickable link. IMPORTANT: STRICTLY use the exact relative URL path provided in the tool response (e.g. `[ProductName](/Details/7)`). DO NOT prepend any external domain like `https://appliancesheaven.com`.
"""

# ─── Inventory Search Tool ────────────────────────────────────────────────────
def search_inventory(
    query: str = "",
    category: str = "",
    max_price: float = 0,
    min_price: float = 0,
    with_discount: bool = False,
    limit: int = 5
) -> dict:
    """
    Search the Appliances Heaven product inventory.
    """
    try:
        products = Product.objects.filter(status='PUBLISH').select_related('categories', 'subcategories')

        if query:
            for term in query.split():
                products = products.filter(name__icontains=term)

        if category:
            products = products.filter(categories__name__icontains=category)

        if max_price > 0:
            products = products.filter(price__lte=max_price)

        if min_price > 0:
            products = products.filter(price__gte=min_price)

        if with_discount:
            products = products.filter(discount_percentage__gt=0)

        limit = min(int(limit), 10)
        products = products.order_by('-id')[:limit]

        result = []
        for p in products:
            discounted_price = float(p.get_discounted_price())
            original_price   = float(p.price)
            result.append({
                'id':            p.id,
                'name':          p.name,
                'category':      p.categories.name if p.categories else 'N/A',
                'subcategory':   p.subcategories.name if p.subcategories else 'N/A',
                'original_price': original_price,
                'discounted_price': discounted_price,
                'discount_pct':  float(p.discount_percentage),
                'is_deal':       p.is_deal_of_day,
                'description':   p.description[:150] + '...' if len(p.description) > 150 else p.description,
                'url':           f'/Details/{p.id}',
                'rating':        'N/A',
            })

        return {
            'status': 'success',
            'count':  len(result),
            'products': result,
            'message': f'Found {len(result)} product(s) matching your query.'
        }
    except Exception as e:
        return {
            'status': 'error',
            'products': [],
            'message': f'Search failed: {str(e)}'
        }


# ─── Tool Declaration ─────────────────────────────────────────────────────────
INVENTORY_TOOL = genai.protos.Tool(
    function_declarations=[
        genai.protos.FunctionDeclaration(
            name='search_inventory',
            description='Search the Appliances Heaven product inventory for real products. Use this whenever the user asks about products, prices, recommendations or availability.',
            parameters=genai.protos.Schema(
                type=genai.protos.Type.OBJECT,
                properties={
                    'query': genai.protos.Schema(
                        type=genai.protos.Type.STRING,
                        description='Product name or keyword. ALWAYS correct spelling errors before searching (e.g. "iphoe" -> "iphone").'
                    ),
                    'category': genai.protos.Schema(
                        type=genai.protos.Type.STRING,
                        description='Category name e.g. "AC", "Refrigerator", "TV", "Washing Machine", "Mobile"'
                    ),
                    'max_price': genai.protos.Schema(
                        type=genai.protos.Type.NUMBER,
                        description='Maximum price in INR. e.g. 30000 for "under 30k"'
                    ),
                    'min_price': genai.protos.Schema(
                        type=genai.protos.Type.NUMBER,
                        description='Minimum price in INR'
                    ),
                    'with_discount': genai.protos.Schema(
                        type=genai.protos.Type.BOOLEAN,
                        description='If true, only return products that are on discount/offer'
                    ),
                    'limit': genai.protos.Schema(
                        type=genai.protos.Type.INTEGER,
                        description='Max number of results to return (max 10)'
                    ),
                }
            )
        )
    ]
)


# ─── Initialize Model ─────────────────────────────────────────────────────────
def get_model():
    return genai.GenerativeModel(
        model_name='gemini-2.5-flash',
        system_instruction=ELECTROBOT_SYSTEM_PROMPT,
        tools=[INVENTORY_TOOL],
    )


# ─── Chat Endpoint ────────────────────────────────────────────────────────────
@csrf_exempt
@require_http_methods(["POST"])
def electrobot_chat(request):
    try:
        data    = json.loads(request.body)
        message = data.get('message', '').strip()
        history = data.get('history', [])   # [{role, parts:[{text}]}]

        if not message:
            return JsonResponse({'error': 'Empty message'}, status=400)

        model = get_model()

        # Convert history to Gemini format
        gemini_history = []
        for entry in history:
            role  = entry.get('role', 'user')
            parts = entry.get('parts', [])
            gemini_history.append({'role': role, 'parts': parts})

        chat = model.start_chat(history=gemini_history)

        # Send message — handle tool calls in a loop
        response = chat.send_message(message)

        # Agentic loop: handle function calls
        MAX_ROUNDS = 5
        for _ in range(MAX_ROUNDS):
            # Check if model wants to call a function
            fc = None
            for part in response.candidates[0].content.parts:
                if part.function_call.name:
                    fc = part.function_call
                    break

            if fc is None:
                break  # No more tool calls, we have the final text

            # Execute the requested tool
            fn_name = fc.name
            fn_args = dict(fc.args) if fc.args else {}

            if fn_name == 'search_inventory':
                tool_result = search_inventory(**fn_args)
            else:
                tool_result = {'status': 'error', 'message': 'Unknown tool'}

            # Send tool result back to model
            response = chat.send_message(
                genai.protos.Content(
                    parts=[genai.protos.Part(
                        function_response=genai.protos.FunctionResponse(
                            name=fn_name,
                            response={'result': tool_result}
                        )
                    )],
                    role='function'
                )
            )

        # Extract final text response
        final_text = ''
        for part in response.candidates[0].content.parts:
            if hasattr(part, 'text') and part.text:
                final_text += part.text

        if not final_text:
            final_text = "I'm having a moment. Let me try again! ⚡"

        return JsonResponse({
            'reply':   final_text,
            'status':  'success',
        })

    except Exception as e:
        error_msg = str(e)
        print(f"ElectroBot Exception: {error_msg}")
        if "API_KEY_INVALID" in error_msg or "API key not valid" in error_msg:
            reply = "⚡ ElectroBot Error: It looks like the Gemini API Key is invalid or missing. Please add a valid API key in `AH/settings.py`."
        elif "leaked" in error_msg.lower():
            reply = "⚡ ElectroBot Error: Your Gemini API key was disabled by Google because it was leaked. Please generate a new key in Google AI Studio and update `AH/settings.py`."
        elif "429" in error_msg or "quota" in error_msg.lower() or "exhausted" in error_msg.lower():
            reply = "⚡ ElectroBot Error: Rate limit exceeded (Too many fast messages). Please wait a few seconds and try again."
        else:
            reply = f"⚡ ElectroBot is momentarily unavailable at the moment."
            
        return JsonResponse({
            'reply':   reply,
            'status':  'error'
        }, status=200)   # Return 200 so frontend still shows the message


# ─── Chatbot Page View ────────────────────────────────────────────────────────
def electrobot_page(request):
    return render(request, 'chatbot.html')
