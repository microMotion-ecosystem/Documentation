# API Documentation - Journal Entries & General Ledger Service (`api_journal_entries_service`)

## **Overview**

خدمة قيود اليومية ودفتر الأستاذ مسؤولة عن **تسجيل وتحليل قيود اليومية المالية وتحديث الحسابات داخل دفتر الأستاذ العام**. تتيح هذه الخدمة إدخال كافة الحركات المالية، بما في ذلك المعاملات بين الحسابات المختلفة، وتسجيلها وفقًا للمعايير المحاسبية.

## **Endpoints**

### **1. إنشاء قيد يومية جديد**
- **Endpoint**: `/api/journal-entries`
- **Method**: `POST`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `create_journal_entry`

#### **Request Body**
```json
{
  "entry_number": "JE-2025001",
  "date": "2025-02-20",
  "description": "Purchase of office equipment",
  "transactions": [
    {
      "account_id": "acc-1001",
      "debit": 5000,
      "credit": 0,
      "currency": "SAR"
    },
    {
      "account_id": "acc-2001",
      "debit": 0,
      "credit": 5000,
      "currency": "SAR"
    }
  ],
  "metadata": {},
  "relation_keys": {
    "invoice_id": "INV-12345"
  },
  "tags": ["equipment", "expense"],
  "logs": []
}
```

#### **Response**
```json
{
  "journal_entry_id": "JE-2025001",
  "status": "Pending",
  "message": "Journal entry created successfully."
}
```

---

### **2. الحصول على جميع قيود اليومية**
- **Endpoint**: `/api/journal-entries`
- **Method**: `GET`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `view_journal_entries`

#### **Response**
```json
[
  {
    "journal_entry_id": "JE-2025001",
    "date": "2025-02-20",
    "description": "Purchase of office equipment",
    "status": "Approved"
  }
]
```

---

### **3. الحصول على تفاصيل قيد يومية محدد**
- **Endpoint**: `/api/journal-entries/{journal_entry_id}`
- **Method**: `GET`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `view_journal_entry`

#### **Response**
```json
{
  "journal_entry_id": "JE-2025001",
  "date": "2025-02-20",
  "description": "Purchase of office equipment",
  "transactions": [
    {
      "account_id": "acc-1001",
      "debit": 5000,
      "credit": 0,
      "currency": "SAR"
    },
    {
      "account_id": "acc-2001",
      "debit": 0,
      "credit": 5000,
      "currency": "SAR"
    }
  ],
  "status": "Approved",
  "metadata": {},
  "relation_keys": {
    "invoice_id": "INV-12345"
  },
  "tags": ["equipment", "expense"],
  "logs": []
}
```

---

### **4. تحديث حالة قيد يومية**
- **Endpoint**: `/api/journal-entries/{journal_entry_id}/status`
- **Method**: `PATCH`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `update_journal_entry_status`

#### **Request Body**
```json
{
  "new_status": "Approved",
  "metadata": {
    "approved_by": "admin_user_001"
  }
}
```

#### **Response**
```json
{
  "journal_entry_id": "JE-2025001",
  "previous_status": "Pending",
  "new_status": "Approved",
  "updated_at": "2025-02-21T10:00:00Z"
}
```

---

### **5. الحصول على رصيد الحسابات من دفتر الأستاذ**
- **Endpoint**: `/api/ledger/accounts-balance`
- **Method**: `GET`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `view_ledger`

#### **Response**
```json
{
  "account_balances": [
    { "account_id": "acc-1001", "balance": 15000, "currency": "SAR" },
    { "account_id": "acc-2001", "balance": -5000, "currency": "SAR" }
  ]
}
```

---

### **6. الحصول على تفاصيل حساب معين من دفتر الأستاذ**
- **Endpoint**: `/api/ledger/accounts/{account_id}`
- **Method**: `GET`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `view_ledger`

#### **Response**
```json
{
  "account_id": "acc-1001",
  "transactions": [
    { "date": "2025-02-20", "debit": 5000, "credit": 0 },
    { "date": "2025-02-21", "debit": 10000, "credit": 0 }
  ],
  "balance": 15000,
  "currency": "SAR"
}
```

---

### **7. إنشاء إدخال يدوي في دفتر الأستاذ**
- **Endpoint**: `/api/ledger/manual-entry`
- **Method**: `POST`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `create_manual_ledger_entry`

#### **Request Body**
```json
{
  "account_id": "acc-3001",
  "date": "2025-02-22",
  "debit": 2000,
  "credit": 0,
  "description": "Manual adjustment"
}
```

#### **Response**
```json
{
  "ledger_entry_id": "LE-2025001",
  "message": "Manual ledger entry created successfully."
}
```

---

## **الملاحظات**
- تم توسيع الخدمة لدعم **دفتر الأستاذ العام**.
- جميع الحسابات المالية يتم تحديثها تلقائيًا بناءً على قيود اليومية.
- يدعم النظام إدخال تعديلات يدوية على دفتر الأستاذ عند الحاجة.


