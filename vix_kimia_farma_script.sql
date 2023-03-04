/*
Author: Faiz Naida Salimah
Date: 01/03/2023
Tool used: MySQL Workbench 
*/

/*
--------------------------
CREATE DATABASE DAN TABEL
--------------------------
*/

-- Membuat schema database
CREATE SCHEMA kimia_farma;
USE kimia_farma;

-- Membuat tabel 
-- Tabel penjualan
CREATE TABLE `kimia_farma`.`penjualan` (
  `id_distributor` VARCHAR(45) NOT NULL,
  `id_cabang` VARCHAR(45) NULL,
  `id_invoice` VARCHAR(45) NULL,
  `tanggal` DATE NULL,
  `id_customer` VARCHAR(45) NULL,
  `id_barang` VARCHAR(45) NULL,
  `jumlah` INT NULL,
  `unit` VARCHAR(45) NULL,
  `harga` DECIMAL(45) NULL,
  `mata_uang` VARCHAR(45) NULL,
  `brand_id` VARCHAR(45) NULL,
  `lini` VARCHAR(45) NULL,
  PRIMARY KEY (`id_invoice`));

-- Tabel barang
CREATE TABLE `kimia_farma`.`barang` (
  `kode_barang` VARCHAR(45) NOT NULL,
  `sektor` VARCHAR(45) NULL,
  `nama_barang` VARCHAR(45) NULL,
  `tipe` VARCHAR(45) NULL,
  `nama_tipe` VARCHAR(45) NULL,
  `kode_lini` VARCHAR(45) NULL,
  `lini` VARCHAR(45) NULL,
  `kemasan` VARCHAR(45) NULL,
  PRIMARY KEY (`kode_barang`));

-- tabel pelanggan
CREATE TABLE `kimia_farma`.`pelanggan` (
  `id_customer` VARCHAR(45) NOT NULL,
  `level` VARCHAR(45) NULL,
  `nama` VARCHAR(45) NULL,
  `id_cabang` VARCHAR(45) NULL,
  `cabang_sales` VARCHAR(45) NULL,
  `id_group` VARCHAR(45) NULL,
  `group` VARCHAR(45) NULL,
  PRIMARY KEY (`id_customer`));
  
/*
-- setelah membuat database dan tabel lalu melakukan import dataset
1. Select tabel, next
2. Klik pada icon import record from an external file, next
3. Select file to import, next
4. Centang use existing tabel dan truncate table before import, pastikan nama tabel sesuai, next
5. Pastikan nama kolom sesuai, next
6. Klik next pada import data
*/


/*
--------------------------
MEMBUAT TABEL BASE
--------------------------
*/

-- Cek unik value pada id_invoice
SELECT COUNT(DISTINCT(id_invoice)) FROM penjualan;


-- Membuat datamart base table penjualan
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

-- Menentukan primary key
ALTER TABLE base_table ADD PRIMARY KEY(id_invoice);


/*
--------------------------
MEMBUAT TABEL AGGREGAT
--------------------------
*/

-- Membuat datamart aggregat table penjualan
CREATE TABLE agg_table (
SELECT
    tanggal,
    MONTHNAME(tanggal) AS bulan,
    id_invoice,
    cabang_sales AS lokasi_cabang,
    nama AS pelanggan,
    nama_barang AS produk,
    lini AS merek,
    jumlah AS jumlah_produk_terjual,
    harga AS harga_satuan,
    (jumlah * harga) AS total_pendapatan
FROM base_table
ORDER BY 1, 4, 5, 6, 7, 8, 9, 10
);
