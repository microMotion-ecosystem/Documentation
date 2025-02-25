# API Reference for Invoices Service (`api_invoice_service`)

## **Overview**

خدمة الفواتير مسؤولة عن إدارة فواتير المبيعات، احتساب الضرائب، وإصدار **QR Code** للفواتير الإلكترونية وفقًا للمعايير المحاسبية. كما توفر دعمًا للإشعارات الدائنة والمدينة، مما يسمح بإلغاء الفاتورة أو استردادها جزئيًا أو كليًا.

## **1. إنشاء فاتورة جديدة**

### **وصف العملية**

يتيح هذا الـ API إنشاء فاتورة جديدة تتضمن بيانات العميل، المنتجات، الضرائب، وإجمالي المبلغ. يتم احتساب الضرائب تلقائيًا ويتم إنشاء **QR Code** وفقًا لمتطلبات الفوترة الإلكترونية.

### **الشروط**

- يجب أن يكون رقم الفاتورة فريدًا.
- جميع المنتجات المدرجة يجب أن تكون مسجلة مسبقًا في النظام.
- يجب أن يكون الحساب مرتبطًا بعميل مسجل.

### **Endpoint Details**

- **URL**: `/api/invoices`
- **Method**: `POST`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `create_invoice`

### **Request Body**

```json
{
  "invoice_number": "INV-2025001",
  "customer_id": "cust-12345",
  "items": [
    {
      "product_id": "prod-67890",
      "description": "Laptop Dell XPS",
      "quantity": 1,
      "unit_price": 5000,
      "tax_rate": 15,
      "total_price": 5750
    },
    {
      "product_id": "prod-67891",
      "description": "Laptop Samsung",
      "quantity": 1,
      "unit_price": 1000,
      "tax_rate": 15,
      "total_price": 1150
    }
  ],
  "refunded_items": [],
  "total_amount": 6900,
  "currency": "SAR",
  "tax_amount": 900,
  "status": "Pending",
  "qr_code": "base64_encoded_string",
  "addition_fields": {},
  "metadata": {},
  "relation_keys": {
    "customer_id": "cust-12345",
    "order_id": "ord-98765"
  },
  "tags": ["electronics", "laptop", "dell"],
  "logs": []
}
```

## **2. الحصول على جميع الفواتير**

### **وصف العملية**

يُستخدم هذا الـ API لاسترجاع جميع الفواتير المسجلة في النظام، مع إمكانية تصفية النتائج حسب العميل، الحالة، أو النطاق الزمني.

### **الشروط**

- يجب أن يكون المستخدم لديه صلاحية `view_invoices`.

### **Endpoint Details**

- **URL**: `/api/invoices`
- **Method**: `GET`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `view_invoices`

### **Response**

```json
[
  {
    "invoice_number": "INV-2025001",
    "customer_id": "cust-12345",
    "total_amount": 5750,
    "currency": "SAR",
    "status": "Paid",
    "qr_code": "base64_encoded_string"
  }
]
```

## **3. إلغاء فاتورة**

### **وصف العملية**

يتم استخدام هذا الـ API لإلغاء فاتورة صادرة. في حالة الفواتير المدفوعة، يتطلب الإلغاء إنشاء إشعار دائن لاسترداد المبلغ.

### **الشروط**

- لا يمكن إلغاء الفواتير المدفوعة إلا بعد استرجاع قيمتها بإشعار دائن.

### **Endpoint Details**

- **URL**: `/api/invoices/{invoice_id}/cancel`
- **Method**: `POST`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `cancel_invoice`

### **Response**

```json
{
  "message": "Invoice INV-2025001 has been cancelled successfully."
}
```

## **4. إنشاء إشعار دائن (استرجاع جزئي/كامل للفاتورة)**

### **وصف العملية**

يتم استخدام هذا الـ API لإصدار إشعار دائن لاسترجاع قيمة الفاتورة كليًا أو جزئيًا.

### **الشروط**

- لا يمكن أن يتجاوز المبلغ المسترجع إجمالي الفاتورة.
- يجب تقديم سبب واضح للإشعار الدائن.

### **Endpoint Details**

- **URL**: `/api/invoices/{invoice_id}/credit-note`
- **Method**: `POST`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `create_credit_note`

### **Request Body**

```json
{
  "amount": 1150,
  "reason": "Customer returned the Laptop Samsung",
  "metadata": {
    "returned_product_id": "prod-67891",
    "returned_quantity": 1
  }
}
```

### **Response**

```json
{
  "credit_note_id": "CN-2025002",
  "invoice_id": "INV-2025001",
  "amount": 1150,
  "status": "Approved",
  "metadata": {
    "returned_product_id": "prod-67891",
    "returned_quantity": 1
  }
}
```

## **5. إنشاء إشعار مدين (إضافة رسوم إضافية للفاتورة)**\*

### **وصف العملية**

يتم استخدام هذا الـ API لإنشاء إشعار مدين لإضافة رسوم إضافية إلى فاتورة قائمة.

### **الشروط**

- لا يمكن أن يكون المبلغ المضاف سلبيًا.
- يجب أن يكون مرتبطًا بسبب واضح مثل رسوم الشحن الإضافية.

### **Endpoint Details**

- **URL**: `/api/invoices/{invoice_id}/debit-note`
- **Method**: `POST`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `create_debit_note`

### **Request Body**

```json
{
  "amount": 200,
  "reason": "Additional shipping cost",
  "metadata": {}
}
```

### **Response**

```json
{
  "debit_note_id": "DN-2025001",
  "invoice_id": "INV-2025001",
  "amount": 200,
  "status": "Approved"
}
```





## **6. تغيير حالة الفاتورة**

### **وصف العملية**

يتم استخدام هذا الـ API لتحديث حالة الفاتورة، مثل تحويلها من "معلقة" إلى "مدفوعة" أو "ملغاة".

### **الشروط**

- لا يمكن تغيير حالة الفاتورة إلى "مدفوعة" إلا بعد التأكد من استلام الدفعة.

- لا يمكن تغيير حالة الفاتورة إلى "ملغاة" إذا كان هناك إشعار دائن مرتبط بها.

### **Endpoint Details**

- **URL**: `/api/invoices/{invoice_id}/status`

- **Method**: `PATCH`

- **Auth Required**: ✅ نعم

- **Permissions Required**: `update_invoice_status`

### **Request Body**

```json

{

"new_status": "Paid",

"metadata": {

"payment_reference": "PAY-98765"

}

}

```

### **Response**

```json

{

"invoice_id": "INV-2025001",

"previous_status": "Pending",

"new_status": "Paid",

"updated_at": "2025-02-17T12:00:00Z"

}

```
---
.

# توثيق نموذج الفاتورة

```
{
  "invoice_number": "INV-2025001",
  "customer": {
    "customer_id": "cust-12345",
    "name": "Ahmed Ali",
    "email": "ahmed.ali@example.com",
    "phone": "+966123456789",
    "billing_address": "123 King Fahd Road, Riyadh, Saudi Arabia",
    "shipping_address": "456 Olaya Street, Riyadh, Saudi Arabia"
  },
  "items": [
    {
      "product_id": "prod-67890",
      "description": "Laptop Dell XPS",
      "quantity": 1,
      "unit_price": 5000,
      "adjusted_unit_price": 4500,  // السعر بعد الخصم
      "unit_price_after_tax": 5175,  // السعر بعد الضريبة
      "type": "product"
    },
    {
      "product_id": "prod-67891",
      "description": "Laptop Samsung",
      "quantity": 1,
      "unit_price": 1000,
      "adjusted_unit_price": 900,  // السعر بعد الخصم
      "unit_price_after_tax": 1035,  // السعر بعد الضريبة
      "type": "product"
    },
    {
      "product_id": "discount-total",
      "description": "Global Discount - Promo Code: WELCOME5",
      "quantity": 1,
      "unit_price": -310.5, 
      "adjusted_unit_price": -310.5,
      "unit_price_after_tax": -310.5,  // لا يتم فرض ضريبة على الخصم
      "type": "discount"
    },
    {
      "product_id": "fee-shipping",
      "description": "Shipping Fee",
      "quantity": 1,
      "unit_price": 50,
      "adjusted_unit_price": 50,
      "unit_price_after_tax": 57.5,  // السعر بعد الضريبة
      "type": "fee"
    },
    {
      "product_id": "fee-processing",
      "description": "Payment Processing Fee",
      "quantity": 1,
      "unit_price": 20,
      "adjusted_unit_price": 20,
      "unit_price_after_tax": 23,  // السعر بعد الضريبة
      "type": "fee"
    },
    {
      "product_id": "service-001",
      "description": "Extended Warranty Service",
      "quantity": 1,
      "unit_price": 200,
      "adjusted_unit_price": 200,
      "unit_price_after_tax": 230,  // السعر بعد الضريبة
      "type": "service"
    }
  ],
  "refunded_items": [
    {
      "product_id": "prod-67891",
      "description": "Laptop Samsung",
      "quantity": 1,
      "unit_price": 1000,
      "adjusted_unit_price": 900,
      "unit_price_after_tax": 1035,
      "refund_amount": 1035,
      "refund_date": "2025-02-20",
      "refund_reason": "Defective product"
    }
  ],
  "credit_debit_notes": [
    {
      "note_id": "CDN-001",
      "type": "credit",
      "amount": 1035,
      "reason": "Refund for defective product",
      "date": "2025-02-20",
      "reference_invoice": "INV-2025001",
      "status":"Pending" // Pending, Approved, Rejected, Applied , Refunded, Paid 
    }
  ],
  "subtotal": 5170,  
  "total_after_discount": 5170,  
  "total_before_tax": 6205,  
  "tax_amount": 930.75,  // يتم احتساب الضريبة على المجموع بعد الخصم
  "grand_total": 7135.75,  // المبلغ النهائي بعد الضرائب
  "amount_paid": 3500,  // المبلغ المدفوع جزئيًا
  "remaining_balance": 2600.75,  // المبلغ المتبقي
  "currency": "SAR",
  "status": "Partially Paid", // Pending, Approved, Rejected, Applied, Refunded, Paid 
  "qr_code": "base64_encoded_string",
  "payments": [
    {
      "amount": 2000,
      "payment_method": "Credit Card",
      "payment_date": "2025-02-18",
      "receipt_number": "RCPT-987654"
    },
    {
      "amount": 1500,
      "payment_method": "Bank Transfer",
      "payment_date": "2025-02-19",
      "receipt_number": "RCPT-987655"
    }
  ],
  "addition_fields": {
    "delivery_instructions": "Leave package at front door if no one is home",
    "customer_notes": "Please ensure packaging is intact before delivery",
    "internal_reference": "INV-REF-98765",
    "promo_code": "WELCOME5"
  },
  "metadata": {
    "invoice_created_by": "system_user_001",
    "payment_due_date": "2025-02-25",
    "last_updated": "2025-02-17T14:30:00Z",
    "original_currency": "USD",
    "exchange_rate": 3.75
  },
  "relation_keys": {
    "customer_id": "cust-12345",
    "order_id": "ord-98765"
  },
  "tags": ["electronics", "laptop", "dell"],
  "logs": [
    {
      "timestamp": "2025-02-17T12:00:00Z",
      "action": "Invoice Created",
      "performed_by": "system_user_001"
    },
    {
      "timestamp": "2025-02-18T09:15:00Z",
      "action": "Discount Applied",
      "performed_by": "admin_user_002",
      "details": "Applied 5% promo code WELCOME5"
    },
    {
      "timestamp": "2025-02-19T14:45:00Z",
      "action": "Partial Payment Received",
      "performed_by": "payment_gateway",
      "details": "Payment of 3500 SAR received via credit card and bank transfer"
    },
    {
      "timestamp": "2025-02-20T16:00:00Z",
      "action": "Refund Processed",
      "performed_by": "admin_user_003",
      "details": "Refunded 1035 SAR for Laptop Samsung due to defect"
    }
  ]
}
```

# **توثيق نموذج الفاتورة**

## **مقدمة**
يهدف هذا التوثيق إلى شرح تفاصيل نموذج الفاتورة (`Invoice`)، والذي يتضمن معلومات العميل، المنتجات، الخصومات، الضرائب، المدفوعات، الإشعارات الدائنة والمدينة، والسجلات المرتبطة بالفاتورة.

---

## **هيكلة الفاتورة**

### **1. تفاصيل الفاتورة (`invoice_number`)**
- `invoice_number`: رقم فريد يميز الفاتورة.
- `status`: حالة الفاتورة، يمكن أن تكون:
  - `Pending`: الفاتورة بانتظار الدفع.
  - `Partially Paid`: تم الدفع جزئيًا.
  - `Paid`: تم دفع الفاتورة بالكامل.
  - `Refunded`: تم رد المبلغ للعميل.
  - `Rejected`: تم رفض الفاتورة.

---

### **2. بيانات العميل (`customer`)**
- `customer_id`: معرّف العميل الفريد.
- `name`: اسم العميل.
- `email`: البريد الإلكتروني.
- `phone`: رقم الهاتف.
- `billing_address`: عنوان الفوترة.
- `shipping_address`: عنوان الشحن.

---

### **3. المنتجات والخدمات (`items`)**
لكل عنصر داخل `items`:
- `product_id`: رقم المنتج الفريد.
- `description`: وصف العنصر.
- `quantity`: عدد الوحدات المطلوبة.
- `unit_price`: سعر الوحدة بدون خصومات أو ضرائب.
- `adjusted_unit_price`: السعر بعد تطبيق أي خصومات.
- `unit_price_after_tax`: السعر النهائي بعد تطبيق الضريبة.
- `type`: نوع العنصر، ويمكن أن يكون:
  - `product`: منتج.
  - `service`: خدمة.
  - `fee`: رسوم إضافية.
  - `discount`: خصم مطبق على الفاتورة.

---

### **4. المرتجعات (`refunded_items`)**
إذا تم استرجاع أحد المنتجات:
- `product_id`: معرف المنتج المسترجع.
- `description`: وصف المنتج المسترجع.
- `quantity`: عدد الوحدات المسترجعة.
- `refund_amount`: قيمة الاسترجاع.
- `refund_date`: تاريخ الاسترجاع.
- `refund_reason`: سبب الاسترجاع.

---

### **5. إشعارات دائنة أو مدينة (`credit_debit_notes`)**
يتم استخدام هذه الحقول لإدارة الإشعارات المالية المرتبطة بالفاتورة.
- `note_id`: معرف الإشعار الدائن/المدين.
- `type`: نوع الإشعار (`credit` للإشعار الدائن أو `debit` للإشعار المدين).
- `amount`: المبلغ المرتبط بالإشعار.
- `reason`: سبب إنشاء الإشعار.
- `date`: تاريخ الإشعار.
- `reference_invoice`: رقم الفاتورة المرتبط بالإشعار.
- `status`: حالة الإشعار:
  - `Pending`: لم يتم الموافقة بعد.
  - `Approved`: تمت الموافقة عليه.
  - `Applied`: تم تطبيقه على الفاتورة.
  - `Refunded`: تم استرداد المبلغ للعميل.
  - `Paid`: تم دفع المبلغ من العميل.

---

### **6. الحسابات المالية (`subtotal`, `tax_amount`, `grand_total`)**
- `subtotal`: المجموع الفرعي بعد الخصومات ولكن قبل الضرائب.
- `total_after_discount`: المجموع بعد الخصومات بدون الضريبة.
- `total_before_tax`: المجموع قبل الضريبة.
- `tax_amount`: إجمالي الضرائب المفروضة على الفاتورة.
- `grand_total`: الإجمالي النهائي بعد الضرائب.
- `amount_paid`: المبلغ المدفوع حتى الآن.
- `remaining_balance`: الرصيد المتبقي الذي لم يُدفع بعد.
- `currency`: العملة المستخدمة.

---

### **7. المدفوعات (`payments`)**
توثيق جميع المدفوعات المرتبطة بالفاتورة.
- `amount`: قيمة الدفعة.
- `payment_method`: طريقة الدفع (بطاقة ائتمان، تحويل بنكي، إلخ).
- `payment_date`: تاريخ الدفع.
- `receipt_number`: رقم سند الدفع إن وجد.

---

### **8. الحقول الإضافية (`addition_fields`)**
تُستخدم لتخزين بيانات مخصصة حسب الحاجة.
- `delivery_instructions`: ملاحظات حول التوصيل.
- `customer_notes`: ملاحظات العميل الخاصة.
- `internal_reference`: مرجع داخلي للفاتورة.
- `promo_code`: كود الخصم المستخدم.

---

### **9. بيانات إضافية (`metadata`)**
توفر معلومات إضافية تساعد في تحليل الفواتير.
- `invoice_created_by`: معرف المستخدم الذي أنشأ الفاتورة.
- `payment_due_date`: تاريخ استحقاق الدفع.
- `last_updated`: آخر تحديث للفاتورة.
- `original_currency`: العملة الأصلية للفاتورة.
- `exchange_rate`: سعر الصرف المستخدم.

---

### **10. الروابط والعلاقات (`relation_keys`)**
تُستخدم لربط الفاتورة بعناصر أخرى في النظام.
- `customer_id`: معرّف العميل.
- `order_id`: معرّف الطلب المرتبط بالفاتورة.

---

### **11. السجلات (`logs`)**
توفر تتبعًا زمنيًا لجميع التعديلات والإجراءات التي تمت على الفاتورة.
- `timestamp`: وقت تنفيذ العملية.
- `action`: الإجراء الذي تم اتخاذه.
- `performed_by`: من قام بالإجراء.
- `details`: تفاصيل إضافية حول الحدث.

**أمثلة على السجلات:**
- إنشاء الفاتورة.
- تطبيق خصم.
- استلام دفعة جزئية.
- معالجة استرداد.
- إصدار إشعار دائن.

---

## **الاستنتاج**
نموذج الفاتورة هذا يوفر **إدارة مالية متكاملة** تشمل معلومات العميل، المنتجات، الضرائب، الخصومات، الدفعات، المرتجعات، والإشعارات المالية، مع إمكانية تتبع كل عملية تمت على الفاتورة عبر `logs`.

