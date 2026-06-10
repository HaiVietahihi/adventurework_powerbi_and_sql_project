# 🚴 Adventure Works Sales Intelligence Dashboard

Dự án Business Intelligence end-to-end phân tích hiệu quả kinh doanh cho Adventure Works — công ty sản xuất và phân phối xe đạp, phụ kiện và quần áo thể thao hoạt động tại 6 quốc gia (Mỹ, Úc, Canada, Anh, Đức, Pháp).

---

## 📸 Dashboard Preview

### Trang 1 — Executive Overview
<img width="1205" height="675" alt="Customer_intelligence" src="https://github.com/user-attachments/assets/a73aaf62-613c-4a29-b17d-f3480dfaef10" />


### Trang 2 — Product Performance
<img width="1209" height="685" alt="executive_overview" src="https://github.com/user-attachments/assets/726fd8b6-2a98-41fe-b0c9-ab204c10c7e3" />


### Trang 3 — Customer Intelligence
<img width="1210" height="679" alt="Product_performance" src="https://github.com/user-attachments/assets/2dc4fe6e-625c-4280-9d17-d9142129574e" />

### Trang 4 — Sales Performance
<img width="1210" height="677" alt="Sales_performance" src="https://github.com/user-attachments/assets/e2a2769b-a5e5-401a-aa20-59341b399c00" />

---

## 🛠️ Tech Stack

| Công cụ | Mục đích sử dụng |
|---|---|
| SQL Server 2022 | Lưu trữ dữ liệu, tạo SQL Views |
| Power BI Desktop | Data modeling, DAX measures, Visualization |
| Power Query (M) | Transformation, kiểm tra data quality |
| SSMS | Viết và quản lý SQL queries |
| GitHub | Version control, tài liệu kỹ thuật |

---

## 🗂️ Kiến trúc dữ liệu

### Pipeline tổng quan

```
AdventureWorksDW2022 (SQL Server)
        ↓
  SQL Views (tầng chuẩn bị dữ liệu)
        ↓
  Power BI — Import Mode
  (Power Query → Star Schema → DAX → Dashboard)
```

### Lý do dùng SQL Views thay vì load bảng thô

- Tách biệt tầng chuẩn bị dữ liệu (SQL) và tầng trực quan hóa (Power BI)
- Khi cấu trúc database thay đổi, chỉ cần cập nhật View, không cần sửa Power BI
- Giảm tải dữ liệu không cần thiết, chỉ load đúng cột cần dùng

### Sơ đồ Data Model (Star Schema)

<img width="766" height="658" alt="image" src="https://github.com/user-attachments/assets/fe1e65f8-be61-4c59-a495-a9e3a3117e52" />


### Mô tả các bảng

| Bảng | Loại | Mô tả | Số dòng |
|---|---|---|---|
| `vw_FactSales` | Fact | Giao dịch bán hàng, grain = 1 dòng/sản phẩm/đơn hàng | ~60,000 |
| `vw_DimProduct` | Dimension | Thông tin sản phẩm, subcategory, category (JOIN 3 bảng) | ~300 |
| `vw_DimCustomer` | Dimension | Thông tin khách hàng, địa lý, nhân khẩu học (JOIN DimGeography) | ~18,000 |
| `DimDate` | Dimension | Bảng ngày tháng chuẩn, range 2010–2014 | ~1,800 |
| `DimSalesTerritory` | Dimension | Khu vực bán hàng theo quốc gia và nhóm | ~11 |
| `DimEmployee` | Dimension | Nhân viên bán hàng | ~290 |

---

## 📊 Nội dung Dashboard

### Trang 1 — Executive Overview
Cung cấp cái nhìn tổng quan cho ban lãnh đạo về tình hình kinh doanh toàn công ty.

**KPIs:** Total Revenue, Gross Profit, Profit Margin %, Total Orders, Revenue YoY %

**Visuals:**
- Line chart xu hướng doanh thu theo tháng
- Donut chart tỷ trọng doanh thu theo Category
- Bar chart doanh thu theo năm
- Map phân bố doanh thu theo quốc gia

---

### Trang 2 — Product Performance
Phân tích hiệu quả sản phẩm và danh mục, xác định sản phẩm tạo ra giá trị cao nhất.

**KPIs:** Total Revenue, Gross Profit, Profit Margin %, Total Quantity

**Visuals:**
- Bar chart Top 10 sản phẩm theo doanh thu
- Scatter plot Revenue vs Profit Margin (phát hiện sản phẩm doanh thu cao nhưng margin thấp)
- Pareto chart phân tích 80/20 — Top 20 sản phẩm đóng góp bao nhiêu % tổng doanh thu
- Matrix table Category breakdown với conditional formatting

---

### Trang 3 — Customer Intelligence
Phân tích hành vi và đặc điểm khách hàng để hỗ trợ chiến lược marketing và CRM.

**KPIs:** Total Customers, Avg Revenue per Customer, Total Orders, Avg Order Value

**Visuals:**
- Bar chart phân khúc khách hàng theo RFM Segment
- Column chart doanh thu theo nhóm thu nhập (Income Group)
- Bar chart doanh thu theo nghề nghiệp (Occupation)
- Donut chart phân bố khách hàng theo quốc gia

---

### Trang 4 — Sales Performance
Đánh giá hiệu quả bán hàng theo khu vực địa lý, hỗ trợ Sales Manager theo dõi team.

**KPIs:** Total Revenue, Total Orders, Avg Order Value, Top Territory

**Visuals:**
- Bar chart doanh thu theo khu vực (SalesTerritory)
- Stacked column chart xu hướng đơn hàng theo năm và nhóm khu vực
- Matrix table Territory breakdown với Revenue YoY %
- Map phân bố doanh thu theo quốc gia

---

## 🔍 Key Insights

- **Bikes chiếm ~94% tổng doanh thu** dù số lượng đơn hàng ít hơn Accessories — Avg Order Value cao hơn đáng kể
- **Top 20 sản phẩm đóng góp ~60% tổng doanh thu** — xác nhận nguyên tắc Pareto 80/20
- **Nhóm khách hàng Loyal tạo ra doanh thu lớn nhất** theo phân tích RFM — cần chiến lược giữ chân nhóm này
- **Nhóm thu nhập $60K–$100K** là phân khúc khách hàng đóng góp doanh thu cao nhất
- **Australia là khu vực doanh thu cao nhất** trong tất cả các territory
- **Doanh thu 2013 tăng trưởng ~180% so với 2012** — giai đoạn tăng trưởng mạnh nhất của công ty

---

## 📐 DAX Measures Dictionary

### Nhóm Core Metrics

| Measure | Công thức | Mô tả |
|---|---|---|
| `Total Revenue` | `SUM(vw_FactSales[SalesAmount])` | Tổng doanh thu |
| `Total Cost` | `SUM(vw_FactSales[TotalProductCost])` | Tổng giá vốn |
| `Gross Profit` | `[Total Revenue] - [Total Cost]` | Lợi nhuận gộp |
| `Profit Margin %` | `DIVIDE([Gross Profit], [Total Revenue])` | Tỷ suất lợi nhuận |
| `Total Orders` | `DISTINCTCOUNT(SalesOrderNumber)` | Số đơn hàng |
| `Avg Order Value` | `DIVIDE([Total Revenue], [Total Orders])` | Giá trị đơn trung bình |
| `Total Quantity` | `SUM(vw_FactSales[OrderQuantity])` | Tổng số lượng bán |

### Nhóm Time Intelligence

| Measure | Mô tả |
|---|---|
| `Revenue YTD` | Doanh thu lũy kế từ đầu năm (`TOTALYTD`) |
| `Revenue Previous Month` | Doanh thu tháng trước (`DATEADD -1 MONTH`) |
| `Revenue MoM %` | Tăng trưởng doanh thu tháng so với tháng trước |
| `Revenue Previous Year` | Doanh thu năm trước (`DATEADD -1 YEAR`) |
| `Revenue YoY %` | Tăng trưởng doanh thu năm so với năm trước (dùng `ALL + SELECTEDVALUE` để xử lý filter context) |

### Nhóm Customer Intelligence

| Measure | Mô tả |
|---|---|
| `Total Customers` | Số khách hàng unique (`DISTINCTCOUNT`) |
| `Avg Revenue per Customer` | Doanh thu trung bình mỗi khách hàng |
| `RFM Segment` | Phân khúc khách hàng theo hành vi mua hàng (Calculated Column) |

### Nhóm Product Analysis

| Measure | Mô tả |
|---|---|
| `% Revenue Contribution` | Tỷ trọng doanh thu của từng sản phẩm (dùng `ALL`) |
| `Revenue Rank` | Xếp hạng sản phẩm theo doanh thu (`RANKX`) |
| `Cumulative Revenue %` | Doanh thu tích lũy % cho Pareto chart (dùng `VAR` để xử lý filter context) |
| `Revenue per Order` | Doanh thu trung bình mỗi đơn hàng |
| `Top Territory` | Khu vực có doanh thu cao nhất (`TOPN + FIRSTNONBLANK`) |

---

## 🚀 Hướng dẫn chạy lại dự án

**Yêu cầu:**
- SQL Server Express 2022 (miễn phí)
- SQL Server Management Studio (SSMS)
- Power BI Desktop (miễn phí)

**Các bước:**

1. Tải file `AdventureWorksDW2022.bak` tại:
   `https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks`

2. Restore database vào SQL Server:
   SSMS → Databases → Restore Database → Device → chọn file .bak

3. Chạy file SQL để tạo Views:
   ```
   Mở SSMS → New Query → chạy file sql/create_views.sql
   ```

4. Mở file Power BI:
   ```
   Mở file dashboard/AdventureWorks_Dashboard.pbix
   ```

5. Cập nhật kết nối SQL Server:
   ```
   Home → Transform Data → Data Source Settings → đổi server name về máy local
   ```
