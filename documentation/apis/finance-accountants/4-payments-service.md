<div dir="rtl">

#  (سندات القبض والصرف)  API Reference for Payments Service (`api_payments_service`)
## **مقدمة**

 **يهدف `payments_service` إلى ضمان تسجيل كل معاملة مالية تمت بالفعل ومنع تسجيل أي عمليات لم تُنفذ بعد.**  
 **الميكروسيرفس لا يتعامل مع الفواتير أو المصروفات المستقبلية، وإنما فقط العمليات المالية المنفذة.**

 في أي نظام مالي، هناك نوعان رئيسيان من العمليات المالية:
1. **سند قبض (`Receipt`) 🟢** - عند استلام أموال من عميل أو أي جهة أخرى.
2. **سند صرف (`Payment`) 🔴** - عند دفع أموال لمورد أو موظف.
3. **استرجاع (`Refund`) 🔄** - عند استرجاع مبلغ سبق دفعه أو قبضه.

🚀 ببساطة، **هذه الخدمة مسؤولة عن إثبات وتسجيل جميع المعاملات المالية الفعلية التي تتم داخل النظام**.

---

##  أهداف `payments_service`
1. **تسجيل الأموال الداخلة والخارجة** (عند استلام دفعة من عميل أو دفع مستحق لمورد).
2. **الربط بين المدفوعات والفواتير** لضمان التوافق المحاسبي.
3. **دعم طرق دفع متعددة** (تحويل بنكي، نقدي، بطاقة ائتمانية، شيكات، إلخ).
4. **إتاحة متابعة سجل المدفوعات** لكل عميل أو مورد داخل النظام.
5. **إمكانية إصدار تقارير عن التدفقات النقدية** ومتابعة الحسابات البنكية.

---



## **📌 فهرس الـ Endpoints**
1. [إنشاء سند قبض (`Receipt`)](#إنشاء-سند-قبض-receipt)
2. [إنشاء سند صرف (`Payment`)](#إنشاء-سند-صرف-payment)
3. [إنشاء استرجاع (`Refund`)](#إنشاء-استرجاع-refund)
4. [الحصول على جميع المدفوعات (`Get All Payments`)](#الحصول-على-جميع-المدفوعات-get-all-payments)
5. [استرجاع تفاصيل عملية (`Get Payment by ID`)](#استرجاع-تفاصيل-عملية-get-payment-by-id)
6. [تحديث حالة سند (`Update Payment Status`)](#تحديث-حالة-سند-update-payment-status)
7. [البحث والتصفية (`Filter Payments`)](#البحث-والتصفية-filter-payments)

---

## **1. إنشاء سند قبض (`Receipt`)**
### **📌 وصف العملية**
يستخدم هذا الـ API عند **استلام دفعة مالية** من عميل أو جهة أخرى.  
✅ يتم تسجيل العملية بعد **التأكد من استلام الأموال**.

</div>
### **📌 تفاصيل الـ Endpoint**
- **URL**: `/api/payments/receipts`
- **Method**: `POST`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `create_receipt`

### **📌 Request Body**
```json
{
  "customer_id": "cust-12345",
  "amount": 5000,
  "currency": "SAR",
  "payment_method": "Bank Transfer",
  "payment_reference": "TXN-98765",
  "description": "Payment for Invoice INV-2025001"
}
```

### **📌 Response**
```json
{
  "payment_id": "PM-2025001",
  "status": "Pending",
  "message": "Receipt created successfully."
}
```

<div dir="rtl">

---

## **2. إنشاء سند صرف (`Payment`)**
### **📌 وصف العملية**
يستخدم هذا الـ API عند **دفع أموال لمورد أو موظف**.  
✅ يتم تسجيل العملية بعد **التأكد من تنفيذ عملية الدفع بنجاح**.

### **📌 تفاصيل الـ Endpoint**
- **URL**: `/api/payments/disbursements`
- **Method**: `POST`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `create_disbursement`

### **📌 Request Body**

</div>

```json
{
  "supplier_id": "sup-56789",
  "amount": 3000,
  "currency": "SAR",
  "payment_method": "Credit Card",
  "payment_reference": "TXN-54321",
  "description": "Payment for supplier invoice INV-67890"
}
```

### **📌 Response**
```json
{
  "payment_id": "PM-2025002",
  "status": "Pending",
  "message": "Payment created successfully."
}
```
<div dir="rtl">

---

## **3. إنشاء استرجاع (`Refund`)**
### **📌 وصف العملية**
يستخدم هذا الـ API عند **استرجاع أموال سبق دفعها أو استلامها**.  
✅ يتم تسجيل العملية بعد **إتمام عملية الاسترجاع بنجاح**.

</div>

### **📌 تفاصيل الـ Endpoint**
- **URL**: `/api/payments/refunds`
- **Method**: `POST`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `create_refund`

### **📌 Request Body**
```json
{
  "original_payment_id": "PM-2025002",
  "amount": 3000,
  "currency": "SAR",
  "refund_method": "Bank Transfer",
  "refund_reference": "TXN-65432",
  "description": "Refund for Payment PM-2025002"
}
```

### **📌 Response**
```json
{
  "payment_id": "PM-2025003",
  "status": "Pending",
  "message": "Refund created successfully."
}
```

<div dir="rtl">

---

## **4. الحصول على جميع المدفوعات (`Get All Payments`)**
### **📌 وصف العملية**
يستخدم هذا الـ API لاسترجاع **جميع عمليات الدفع والاستلام والاسترجاع** المسجلة في النظام.

</div>

### **📌 تفاصيل الـ Endpoint**
- **URL**: `/api/payments`
- **Method**: `GET`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `view_payments`

### **📌 Response**
```json
[
  {
    "payment_id": "PM-2025001",
    "payment_type": "Receipt",
    "amount": 5000,
    "currency": "SAR",
    "status": "Approved",
    "transaction_date": "2025-02-23"
  },
  {
    "payment_id": "PM-2025002",
    "payment_type": "Payment",
    "amount": 3000,
    "currency": "SAR",
    "status": "Pending",
    "transaction_date": "2025-02-24"
  }
]
```

<div dir="rtl">

---

## **5. استرجاع تفاصيل عملية (`Get Payment by ID`)**
### **📌 وصف العملية**
يستخدم هذا الـ API لاسترجاع **تفاصيل سند معين** بناءً على `payment_id`.

</div>

### **📌 تفاصيل الـ Endpoint**
- **URL**: `/api/payments/{payment_id}`
- **Method**: `GET`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `view_payment`

### **📌 Response**
```json
{
  "payment_id": "PM-2025001",
  "payment_type": "Receipt",
  "amount": 5000,
  "currency": "SAR",
  "payment_method": "Bank Transfer",
  "payment_reference": "TXN-98765",
  "status": "Approved",
  "transaction_date": "2025-02-23",
  "account_from": "acc-1001",
  "account_to": "acc-2002",
  "description": "Payment for Invoice INV-2025001"
}
```

<div dir="rtl">

---

## **6. تحديث حالة سند (`Update Payment Status`)**
### **📌 وصف العملية**
يستخدم هذا الـ API **لتحديث حالة سند معين** بعد مراجعته من قبل الإدارة المالية.

</div>

### **📌 تفاصيل الـ Endpoint**
- **URL**: `/api/payments/{payment_id}/status`
- **Method**: `PATCH`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `update_payment_status`

### **📌 Request Body**
```json
{
  "new_status": "Approved",
  "metadata": {
    "approved_by": "admin_user_003"
  }
}
```

### **📌 Response**
```json
{
  "payment_id": "PM-2025001",
  "previous_status": "Pending",
  "new_status": "Approved",
  "updated_at": "2025-02-23T15:30:00Z"
}
```

<div dir="rtl">

---

## **7. البحث والتصفية (`Filter Payments`)**
### **📌 وصف العملية**
يستخدم هذا الـ API **للبحث عن المدفوعات باستخدام معايير محددة**.

</div>

### **📌 تفاصيل الـ Endpoint**
- **URL**: `/api/payments/search`
- **Method**: `GET`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `search_payments`

### **📌 Query Parameters**
- `type`: `Receipt`, `Payment`, `Refund`
- `status`: `Pending`, `Approved`, `Rejected`, `Canceled`
- `date_from`, `date_to`
- `customer_id` / `supplier_id`

### **📌 Response**
```json
[
  {
    "payment_id": "PM-2025004",
    "payment_type": "Refund",
    "amount": 2000,
    "currency": "SAR",
    "status": "Approved",
    "transaction_date": "2025-02-25"
  }
]
```

