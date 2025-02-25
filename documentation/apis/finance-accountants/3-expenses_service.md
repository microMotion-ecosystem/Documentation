<div dir="rtl">

### **📌 توثيق `expenses_service` - نظام إدارة المصروفات**

## **مقدمة**
`expenses_service` هو الميكروسيرفس المسؤول عن **إدارة المصروفات** داخل النظام، مثل **الرواتب، المشتريات، فواتير الخدمات، المصروفات الدورية**.  
 **يهدف `expenses_service` إلى تسجيل وتتبع المصروفات وربطها بمراكز التكلفة والموردين، بالإضافة إلى إرسال قيود محاسبية إلى `journal_entries_service`.**

## **📌 فهرس الـ Endpoints**
1. [إنشاء مصروف (`Create Expense`)](#إنشاء-مصروف-create-expense)
2. [الحصول على جميع المصروفات (`Get All Expenses`)](#الحصول-على-جميع-المصروفات-get-all-expenses)
3. [عرض تفاصيل مصروف (`Get Expense by ID`)](#استرجاع-تفاصيل-مصروف-get-expense-by-id)
4. [إلغاء مصروف (`Cancel Expense`)](#إلغاء-مصروف-cancel-expense)
5. [إنشاء إشعار استرداد (`Create Credit Note`)](#إنشاء-إشعار-استرداد-create-credit-note)
6. [إضافة رسوم إضافية (`Create Debit Note`)](#إضافة-رسوم-إضافية-create-debit-note)
7. [تحديث حالة المصروف (`Update Expense Status`)](#تحديث-حالة-المصروف-update-expense-status)

---

## **1. إنشاء مصروف (`Create Expense`)**
### **📌 وصف العملية**
يستخدم هذا الـ API عند **تسجيل مصروف جديد** مثل دفع رواتب، شراء معدات، أو دفع فاتورة خدمات.  
✅ يتم تسجيل المصروفات مع **ربطها بمركز تكلفة ومورد إن وجد**.

### **📌 تفاصيل الـ Endpoint**
- **URL**: `/api/expenses`
- **Method**: `POST`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `create_expense`

### **📌 Request Body**
```json
{
  "expense_number": "EXP-2025001",
  "supplier_id": "sup-56789",
  "cost_center_id": "CC-78901",
  "items": [
    {
      "description": "Office Rent",
      "amount": 5000,
      "tax_rate": 15,
      "total_price": 5750
    },
    {
      "description": "Internet Subscription",
      "amount": 200,
      "tax_rate": 5,
      "total_price": 210
    }
  ],
  "total_amount": 5960,
  "currency": "SAR",
  "tax_amount": 210,
  "status": "Pending",
  "metadata": {},
  "relation_keys": {
    "supplier_id": "sup-56789"
  },
  "tags": ["office", "services"],
  "logs": []
}
```

### **📌 Response**
```json
{
  "expense_id": "EXP-2025001",
  "status": "Pending",
  "message": "Expense created successfully."
}
```

---

## **2. الحصول على جميع المصروفات (`Get All Expenses`)**
### **📌 وصف العملية**
يُستخدم هذا الـ API عرض **جميع المصروفات المسجلة** في النظام.

### **📌 تفاصيل الـ Endpoint**
- **URL**: `/api/expenses`
- **Method**: `GET`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `view_expenses`

### **📌 Response**
```json
[
  {
    "expense_number": "EXP-2025001",
    "supplier_id": "sup-56789",
    "total_amount": 5960,
    "currency": "SAR",
    "status": "Approved"
  }
]
```

---

## **3. عرض تفاصيل مصروف (`Get Expense by ID`)**
### **📌 وصف العملية**
يُستخدم هذا الـ API لعرض **تفاصيل مصروف معين** بناءً على `expense_id`.

### **📌 تفاصيل الـ Endpoint**
- **URL**: `/api/expenses/{expense_id}`
- **Method**: `GET`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `view_expense`

### **📌 Response**
```json
{
  "expense_number": "EXP-2025001",
  "supplier_id": "sup-56789",
  "items": [
    {
      "description": "Office Rent",
      "amount": 5000,
      "tax_rate": 15,
      "total_price": 5750
    }
  ],
  "total_amount": 5960,
  "currency": "SAR",
  "status": "Approved"
}
```

---

## **4. إلغاء مصروف (`Cancel Expense`)**
### **📌 وصف العملية**
يُستخدم هذا الـ API **لإلغاء مصروف مسجل**.

### **📌 تفاصيل الـ Endpoint**
- **URL**: `/api/expenses/{expense_id}/cancel`
- **Method**: `POST`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `cancel_expense`

### **📌 Response**
```json
{
  "message": "Expense EXP-2025001 has been cancelled successfully."
}
```

---

## **5. إنشاء إشعار استرداد (`Create Credit Note`)**
### **📌 وصف العملية**
يُستخدم هذا الـ API **لإصدار إشعار استرداد لمصروف**.

### **📌 تفاصيل الـ Endpoint**
- **URL**: `/api/expenses/{expense_id}/credit-note`
- **Method**: `POST`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `create_credit_note`

---

## **6. إضافة رسوم إضافية (`Create Debit Note`)**
### **📌 وصف العملية**
يُستخدم هذا الـ API **لإضافة رسوم إضافية إلى مصروف**.

### **📌 تفاصيل الـ Endpoint**
- **URL**: `/api/expenses/{expense_id}/debit-note`
- **Method**: `POST`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `create_debit_note`

---

## **7. تحديث حالة المصروف (`Update Expense Status`)**
### **📌 وصف العملية**
يُستخدم هذا الـ API **لتحديث حالة المصروف، مثل تحويله من "معلق" إلى "معتمد" أو "ملغي"**.

### **📌 تفاصيل الـ Endpoint**
- **URL**: `/api/expenses/{expense_id}/status`
- **Method**: `PATCH`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `update_expense_status`

### **📌 Request Body**
```json
{
  "new_status": "Approved",
  "metadata": {
    "approved_by": "finance_manager"
  }
}
```

### **📌 Response**
```json
{
  "expense_id": "EXP-2025001",
  "previous_status": "Pending",
  "new_status": "Approved",
  "updated_at": "2025-03-01T12:00:00Z"
}
```

---

## **العلاقة مع `journal_entries_service`**
📌 عند تسجيل أي مصروف، يتم إرسال **قيد محاسبي تلقائيًا** إلى `journal_entries_service`.  
📌 هذه العملية تضمن **تكامل جميع البيانات المالية** داخل النظام.

---

## **الخلاصة**
✔ `expenses_service` مسؤول عن **تسجيل المصروفات وإدارتها وربطها بمراكز التكلفة والموردين**.  
✔ كل المصروفات يتم **إرسالها إلى `journal_entries_service` لضمان التكامل المحاسبي**.  
✔ يتيح النظام إدارة المصروفات بمرونة، مع إمكانية البحث، الإلغاء، والتحديث بسهولة.

📌 **هل هناك أي إضافات أو تحسينات أخرى تحتاجها؟** 💡
