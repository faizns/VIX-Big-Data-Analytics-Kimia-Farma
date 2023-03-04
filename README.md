# **Virtual Internship Experience: Big Data Analytics - Kimia Farma**
Tool : MySQL <br>
Visualization : Looker Data Studio <br>
Dataset : [VIX Kimia Farma](https://www.rakamin.com/virtual-internship-experience/kimiafarma-big-data-analytics-virtual-internship-program)
<br>

---

## 📂 **Introduction**
VIX Big Data Analytics Kimia Farma merupakan virtual internship experience yang difasilitasi oleh [Rakamin Academy](https://www.rakamin.com/virtual-internship-experience/kimiafarma-big-data-analytics-virtual-internship-program). Pada project ini saya berperan sebagai Data Analyst Intern yang diminta untuk menganalisis dan membuat laporan penjualan perusahaan menggunakan data-data yang telah disediakan. Dari project ini, saya juga banyak belajar tentang data data warehouse, dataleke, dan datamart. <br>
<br>

**Objectives**
- Membuat design datamart (tabel base dan tabel aggregat)
- Membuat visualisasi/dashboard laporan penjualan perusahaan
<br>

**Dataset** <br>
Dataset yang disediakan terdiri dari tabel-tabel berikut:
- penjualan
- barang
- pelanggan
<br>


<details>
  <summary>Klik untuk melihat ERD</summary>

<p align="center">
  <kbd> <img width="400" alt="eer" src="https://user-images.githubusercontent.com/115857221/222876914-a4f50aaf-d339-4d64-8c0b-d450440f2c7b.png"></kbd> <br>
</p>

</details>
<br>

---


## 📂 **Design Datamart**
### Tabel Base
Tabel base adalah tabel yang berisi data asli atau data mentah yang dikumpulkan dari sumbernya dan berisi informasi yang dibutuhkan untuk menjawab pertanyaan atau menyeselasikan masalah tertentu. Tabel base dalam project ini dibuat dari gabungan tabel penjaulan, pelanggan, dan barang dengan primary key pada `invoice_id` . <br>

<details>
  <summary> Klik untuk melihat Query </summary>
    <br>
    
```sql
CREATE TABLE base_table (
SELECT
    j.id_invoice,
    j.tanggal,
    j.id_customer,
    c.nama,
    j.id_distributor,
    j.id_cabang,
    c.cabang_sales,
    c.id_group,
    c.group,
    j.id_barang,
    b.nama_barang,
    j.brand_id,
    b.kode_lini,
    j.lini,
    b.kemasan,
    j.jumlah,
    j.harga,
    j.mata_uang
FROM penjualan j
	LEFT JOIN pelanggan c
		ON c.id_customer = j.id_customer
	LEFT JOIN barang b
		ON b.kode_barang = j.id_barang
ORDER BY j.tanggal
);

ALTER TABLE base_table ADD PRIMARY KEY(id_invoice);
```
    
<br>
</details>
<br>

<p align="center">
    <kbd> <img width="1000" alt="sample table base" src="https://user-images.githubusercontent.com/115857221/222876639-20e1e208-1c5b-4279-8e18-ec937c56f526.png"> </kbd> <br>
    Gambar 1 — Sampel Hasil Pembuatan Tabel Base 
</p>
<br>

### Tabel Aggregat
Tabel agregat adalah tabel yang dibuat dengan mengumpulkan dan menghitung data dari tabel basis. Tabel aggregat ini berisi informasi yang lebih ringkas dan digunakan untuk menganalisis data lebih cepat dan efisien. Hasil tabel ini akan digunakan untuk sumber pembuatan dashboard laporan penjualan.

<details>
  <summary> Klik untuk melihat Query </summary>
    <br>
    
```sql
CREATE TABLE agg_table (
SELECT
    tanggal,
    MONTHNAME(tanggal) AS bulan,        -- kolom nama bulan
    id_invoice,
    cabang_sales AS lokasi_cabang,
    nama AS pelanggan,
    nama_barang AS produk,
    lini AS merek,
    jumlah AS jumlah_produk_terjual,
    harga AS harga_satuan,
    (jumlah * harga) AS total_pendapatan  -- kolom baru total pendapatan
FROM base_table
ORDER BY 1, 4, 5, 6, 7, 8, 9, 10
);
```
    
<br>
</details>
<br>

<p align="center">
    <kbd> <img width="750" alt="sample aggregat" src="https://user-images.githubusercontent.com/115857221/222876809-62000814-75b6-4f82-b6b7-05d00e618315.png"> </kbd> <br>
    Gambar 2 — Sampel Hasil Pembuatan Tabel Aggregat
</p>
<br>

---

## 📂 **Data Visualization**

[Lihat pada halaman Looker Data Studio](https://lookerstudio.google.com/reporting/3c67b292-3be2-484d-bc29-27bd0b4015fd).

<p align="center">
    <kbd> <img width="1000" alt="Kimia_Farma_page-0001" src="https://user-images.githubusercontent.com/115857221/222877035-53371a89-081d-4ec5-9e72-65b0176a96fd.jpg"> </kbd> <br>
    Gambar 3 — Sales Report Dashboard PT. Kimia Farma
</p>
<br>

---
