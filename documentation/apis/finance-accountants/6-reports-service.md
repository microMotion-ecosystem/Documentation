<div dir="rtl"> 

#  **📌 خطة تطوير `reports_service` - نظام التقارير المالية**

## **📌 مقدمة**
`reports_service` هو **ميكروسيرفس متخصص** في **توليد التقارير المالية** اعتمادًا على البيانات المستخرجة من الخدمات الأخرى، مثل:
- `journal_entries_service` (قيود اليومية)
- `invoices_service` (الفواتير)
- `expenses_service` (المصروفات)
- `payments_service` (المدفوعات)
- `accounts_service` (الحسابات المالية)

يهدف هذا الميكروسيرفس إلى **توفير تقارير دقيقة وشاملة** تدعم اتخاذ القرارات المالية والإدارية، وتساعد في الامتثال للمتطلبات التنظيمية في السعودية مثل **التقارير الضريبية والزكوية**.

---

## **📌 أهداف الميكروسيرفس**
✅ إنشاء تقارير مالية **قياسية ومتوافقة مع الأنظمة المحاسبية الدولية**.  
✅ دعم توليد التقارير **يوميًا، أسبوعيًا، شهريًا، أو عند الطلب**.  
✅ إمكانية تصدير التقارير إلى **ملفات PDF أو Excel**.  
✅ توفير واجهة API مرنة تمكن الأنظمة الأخرى من **استهلاك التقارير بسهولة**.  
✅ دعم تكامل البيانات من **عدة مصادر محاسبية ومالية داخل النظام**.

---

## **📌 قائمة التقارير المالية المدعومة**
### 🔹 **التقارير الأساسية**
1. **تقرير المركز المالي (`Balance Sheet`)** - يوضح الوضع المالي العام للشركة في وقت معين.
2. **تقرير الأرباح والخسائر (`Profit & Loss Statement`)** - يعرض الإيرادات والمصروفات وصافي الربح أو الخسارة.
3. **تقرير التدفقات النقدية (`Cash Flow Statement`)** - يتتبع الأموال الواردة والصادرة خلال فترة محددة.

### 🔹 **التقارير المحاسبية في السعودية**
4. **تقرير ضريبة القيمة المضافة (`VAT Report`)** - يساعد في تقديم الإقرارات الضريبية لـ **هيئة الزكاة والضريبة والجمارك (ZATCA)**.
5. **تقرير الزكاة (`Zakat Report`)** - يتم إعداده سنويًا لحساب الزكاة المستحقة على الشركة.

### 🔹 **تقارير إضافية**
6. **تقرير الذمم المدينة والدائنة (`Accounts Receivable & Payable`)** - متابعة المبالغ المستحقة للعملاء والموردين.
7. **تقرير الرواتب (`Payroll Report`)** - يوضح إجمالي الرواتب والخصومات والتكاليف المرتبطة بالموظفين.
8. **تقرير التدفقات النقدية المستقبلية (`Cash Flow Forecast`)** - يساعد في التخطيط المالي وإدارة السيولة.

---

## **📌 هيكلية النظام (Architecture)**
📌 يعتمد `reports_service` على **هيكلية مايكروسيرفس متكاملة** بحيث يتم جمع البيانات من الخدمات الأخرى وتحليلها وإنتاج التقارير المالية المطلوبة.

### 🔹 **المكونات الأساسية:**
1. **`Report Generator`**
    - المسؤول عن **إنشاء التقارير** ومعالجة البيانات المالية.
2. **`Data Aggregator`**
    - يقوم **بتجميع البيانات** من `journal_entries_service`, `invoices_service`, `payments_service`, إلخ.
3. **`Export Module`**
    - مسؤول عن **تحويل التقارير إلى PDF/Excel**.
4. **`API Gateway`**
    - يوفر **واجهة RESTful API** لطلب التقارير وتنزيلها.

---

## **📌 Endpoints الخاصة بـ `reports_service`**

## **1️⃣ تقرير المركز المالي (`Balance Sheet`)**
📌 **لمحة عن التقرير:**
- يعرض **الأصول والخصوم وحقوق الملكية** في وقت معين.

🔹 **Endpoint Details**
- **URL**: `/api/reports/balance-sheet`
- **Method**: `GET`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `view_balance_sheet`

🔹 **Request Parameters**
```json
{
  "as_of_date": "2025-02-24"
}
```

🔹 **Response**
```json
{
  "as_of_date": "2025-02-24",
  "assets": { "cash": 50000, "inventory": 30000, "total_assets": 80000 },
  "liabilities": { "accounts_payable": 20000, "total_liabilities": 20000 },
  "equity": { "owner_equity": 60000, "total_equity": 60000 },
  "status": "Generated Successfully"
}
```

---

## **2️⃣ تقرير الأرباح والخسائر (`Profit & Loss`)**
📌 **لمحة عن التقرير:**
- يعرض **الإيرادات والمصروفات وصافي الأرباح أو الخسائر** خلال فترة محددة.

🔹 **Endpoint Details**
- **URL**: `/api/reports/profit-loss`
- **Method**: `GET`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `view_profit_loss`

🔹 **Request Parameters**
```json
{
  "start_date": "2025-01-01",
  "end_date": "2025-01-31"
}
```

🔹 **Response**
```json
{
  "period": { "start_date": "2025-01-01", "end_date": "2025-01-31" },
  "revenues": { "sales": 75000, "total_revenues": 75000 },
  "expenses": { "salaries": 20000, "rent": 5000, "total_expenses": 25000 },
  "net_profit": 50000,
  "status": "Generated Successfully"
}
```

---

## **3️⃣ تقرير ضريبة القيمة المضافة (`VAT Report`)**
📌 **لمحة عن التقرير:**
- يعرض **تفاصيل الضريبة المضافة على المبيعات والمشتريات**.

🔹 **Endpoint Details**
- **URL**: `/api/reports/vat`
- **Method**: `GET`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `view_vat_report`

🔹 **Response**
```json
{
  "period": { "start_date": "2025-01-01", "end_date": "2025-01-31" },
  "sales_vat": 15000,
  "purchase_vat": 5000,
  "net_vat_due": 10000,
  "status": "Generated Successfully"
}
```

---

## **4️⃣ تقرير الزكاة (`Zakat Report`)**
📌 **لمحة عن التقرير:**
- **حساب الزكاة المستحقة** بناءً على صافي الموجودات.

🔹 **Endpoint Details**
- **URL**: `/api/reports/zakat`
- **Method**: `GET`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `view_zakat_report`

🔹 **Response**
```json
{
  "as_of_date": "2025-12-31",
  "total_assets": 2000000,
  "total_liabilities": 500000,
  "net_assets": 1500000,
  "zakat_due": 37500,
  "status": "Generated Successfully"
}
```

---


## **5️⃣ تقرير الذمم المدينة والدائنة (`Accounts Receivable & Payable Report`)**
📌 **لمحة عن التقرير:**
- يعرض **المبالغ المستحقة على العملاء والمبالغ المستحقة للموردين**، مما يساعد في إدارة التدفقات النقدية.

🔹 **Endpoint Details**
- **URL**: `/api/reports/accounts-receivable-payable`
- **Method**: `GET`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `view_receivable_payable_report`

🔹 **Response**
```json
{
  "as_of_date": "2025-02-24",
  "accounts_receivable": [
    { "customer": "شركة المستقبل", "due_amount": 50000, "due_date": "2025-03-15" }
  ],
  "accounts_payable": [
    { "supplier": "مؤسسة التقنية", "due_amount": 30000, "due_date": "2025-03-10" }
  ],
  "status": "Generated Successfully"
}
```

---

## **6️⃣ تقرير الرواتب (`Payroll Report`)**
📌 **لمحة عن التقرير:**
- يعرض **تفاصيل الرواتب المدفوعة والمستقطعة لكل موظف**، مما يساعد في الامتثال لأنظمة حماية الأجور (WPS).

🔹 **Endpoint Details**
- **URL**: `/api/reports/payroll`
- **Method**: `GET`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `view_payroll_report`

🔹 **Request Parameters**
```json
{
  "start_date": "2025-02-01",
  "end_date": "2025-02-28"
}
```

🔹 **Response**
```json
{
  "period": { "start_date": "2025-02-01", "end_date": "2025-02-28" },
  "employees": [
    {
      "employee_id": "EMP-001",
      "name": "محمد العتيبي",
      "gross_salary": 10000,
      "deductions": 500,
      "net_salary": 9500
    }
  ],
  "total_salaries_paid": 9500,
  "status": "Generated Successfully"
}
```

---

## **7️⃣ تقرير التدفقات النقدية المستقبلية (`Cash Flow Forecast`)**
📌 **لمحة عن التقرير:**
- **يُستخدم للتخطيط المالي** من خلال تحليل التدفقات النقدية المستقبلية **المتوقعة**.

🔹 **Endpoint Details**
- **URL**: `/api/reports/cash-flow-forecast`
- **Method**: `GET`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `view_cash_flow_forecast`

🔹 **Request Parameters**
```json
{
  "forecast_period": "Next 3 Months"
}
```

🔹 **Response**
```json
{
  "forecast_period": "Next 3 Months",
  "expected_cash_inflows": 150000,
  "expected_cash_outflows": 120000,
  "projected_cash_balance": 30000,
  "status": "Generated Successfully"
}
```

---

## **8️⃣ تقرير الإيرادات والمصروفات لكل مركز تكلفة (`Cost Center Report`)**
📌 **لمحة عن التقرير:**
- يعرض **الإيرادات والمصروفات حسب مراكز التكلفة**، مما يساعد في تحليل أداء الأقسام المختلفة داخل الشركة.

🔹 **Endpoint Details**
- **URL**: `/api/reports/cost-center`
- **Method**: `GET`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `view_cost_center_report`

🔹 **Request Parameters**
```json
{
  "start_date": "2025-01-01",
  "end_date": "2025-01-31",
  "cost_center_id": "CC-78901"
}
```

🔹 **Response**
```json
{
  "cost_center_id": "CC-78901",
  "cost_center_name": "Marketing Department",
  "period": { "start_date": "2025-01-01", "end_date": "2025-01-31" },
  "revenues": 30000,
  "expenses": 12000,
  "net_profit": 18000,
  "status": "Generated Successfully"
}
```

---

## **9️⃣ تقرير مخصص (`Custom Report`)**
📌 **لمحة عن التقرير:**
- يسمح **بتحديد نوع التقرير والبيانات المطلوبة يدويًا**، مما يوفر مرونة أكبر.

🔹 **Endpoint Details**
- **URL**: `/api/reports/custom`
- **Method**: `POST`
- **Auth Required**: ✅ نعم
- **Permissions Required**: `generate_custom_report`

🔹 **Request Body**
```json
{
  "report_type": "monthly_summary",
  "start_date": "2025-01-01",
  "end_date": "2025-01-31",
  "filters": {
    "department": "Finance",
    "transaction_type": "Revenue"
  }
}
```

🔹 **Response**
```json
{
  "report_id": "RPT-2025001",
  "status": "Processing",
  "estimated_completion_time": "10 seconds"
}
```

---

## **📌 الهيكل النهائي لـ `reports_service`**
| **التقرير** | **الهدف** |
|------------|----------|
| **تقرير المركز المالي (Balance Sheet)** | معرفة الوضع المالي العام للشركة. |
| **تقرير الأرباح والخسائر (Profit & Loss Statement)** | حساب صافي الأرباح أو الخسائر. |
| **تقرير التدفقات النقدية (Cash Flow Statement)** | تتبع تدفقات الأموال الداخلة والخارجة. |
| **تقرير الإيرادات والمصروفات لكل مركز تكلفة** | تحليل أداء الأقسام المختلفة في الشركة. |
| **تقرير ضريبة القيمة المضافة (VAT Report)** ✅ **إجباري** | حساب الضرائب المستحقة أو المستردة. |
| **تقرير الزكاة (Zakat Report)** ✅ **إجباري** | حساب الزكاة السنوية وفق متطلبات ZATCA. |
| **تقرير الذمم المدينة والدائنة (A/R & A/P Report)** | متابعة الفواتير المستحقة للعملاء والموردين. |
| **تقرير الرواتب (Payroll Report)** ✅ **مهم للشركات** | تتبع الرواتب المدفوعة والمستقطعة. |
| **تقرير التدفقات النقدية المتوقعة (Cash Flow Forecast)** | التخطيط المالي المستقبلي وإدارة السيولة. |
| **تقرير مخصص (Custom Report)** | توليد تقارير مخصصة بناءً على احتياجات الشركة. |

---

## **📌 المزايا الإضافية لـ `reports_service`**
✅ **إمكانية تصدير التقارير إلى PDF أو Excel**  
✅ **يدعم الجدولة التلقائية (Scheduled Reports)**  
✅ **تكامل كامل مع باقي الخدمات المالية**  
✅ **أداء عالٍ باستخدام المعالجة المتوازية عند توليد التقارير الكبيرة**

---

### **🎯 هل ترغب في إضافة أي ميزات أخرى أو هل نبدأ التنفيذ؟ 🚀**
