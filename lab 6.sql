use QLBanHang
/**Câu 1**/
CREATE FUNCTION f1(@tenhp NVARCHAR(50))
RETURNS TABLE (
	Masp Nchar(10) not null,
	Mahangsx nchar(10),
	tensp Nvarchar(20),
	soluong Int,
	mausac Nvarchar(20),
	giaban money,
	donvitinh Nchar(10),
	mota nvarchar(max),
)
AS $$
Begin
    select SanPham.Masp, SanPham.tensp, SanPham.giaban, SanPham.soluong
    FROM SanPham
    INNER JOIN Nhap ON SanPham.Masp = Nhap.Masp
    INNER JOIN Nhanvien ON Nhap.Manv = Nhanvien.Manv
    WHERE  = Nhanvien.Phong ;
end;
/**Câu 2**/
CREATE FUNCTION f2(@ngay_bat_dau DATE, @ngay_ket_thuc DATE)
RETURNS @ngay_bat_dau DATE, @ngay_ket_thuc DATE
AS $$
    SELECT Hangsx.Mahangsx, Hangsx.Tenhang, SanPham.Masp, SanPham.tensp, Nhap.soluongN, Nhap.Ngaynhap
    FROM SanPham
    INNER JOIN Nhap ON SanPham.Masp = Nhap.Masp
    INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
    WHERE Nhap.ngaynhap BETWEEN @ngay_bat_dau AND @ngay_ket_thuc;

/**Câu 3**/
CREATE FUNCTION danh_sach_san_pham_theo_hang_sx_va_lua_chon(@mahangsx INT, @lua_chon INT)
RETURNS TABLE (
    tensp VARCHAR(255),
    soluong INT,
    mausac VARCHAR(255),
    giaban FLOAT,
    donvitinh VARCHAR(255),
    mota TEXT
)
AS $$
    SELECT SanPham.tensp, SanPham.soluong, SanPham.mausac, SanPham.giaban,SanPham.donvitinh, SanPham.mota
    FROM Sanpham
    INNER JOIN Hangsx ON SanPham.Mahangsx = Hangsx.Mahangsx
    WHERE Hangsx.Mahangsx = @mahangsx AND CASE WHEN @lua_chon = 0 THEN Sanpham.soluong = 0 ELSE Sanpham.soluong > 0 END;

/**Câu 4**/
CREATE FUNCTION danh_sach_nhan_vien_theo_ten(ten_nhan_vien VARCHAR(255))
RETURNS TABLE (
    Manv INT,
    Tennv VARCHAR(255),
    gioitinh VARCHAR(10),
    diachi VARCHAR(255),
    sodt VARCHAR(20),
    email VARCHAR(255),
    phong VARCHAR(255)
)
AS $$
    SELECT manv, tennv, gioitinh, diachi, sodt, email, phong
    FROM Nhanvien
    WHERE tennv LIKE '%' || ten_nhan_vien || '%';

/**Câu 5**/
CREATE FUNCTION danh_sach_hang_sx_theo_dia_chi(dia_chi VARCHAR(255))
RETURNS TABLE (
    mahangsx INT,
    tenhang VARCHAR(255),
    diachi VARCHAR(255),
    sodt VARCHAR(20),
    email VARCHAR(255)
)
AS $$
    SELECT mahangsx, tenhang, diachi, sodt, email
    FROM Hangsx
    WHERE diachi LIKE '%' || dia_chi || '%';

/**Câu 6**/
CREATE FUNCTION danh_sach_sp_va_hang_sx_da_xuat_tu_nam_den_nam(nam_bat_dau INT, nam_ket_thuc INT)
RETURNS TABLE (
    masp INT,
    mahangsx INT,
    tensp VARCHAR(255),
    tenhang VARCHAR(255),
    ngayxuat DATE,
    soluongX INT
)
AS $$
    SELECT Xuat.masp, Sanpham.mahangsx, Sanpham.tensp, Hangsx.tenhang, Xuat.ngayxuat, Xuat.soluongX
    FROM Xuat
    JOIN Sanpham ON Xuat.masp = Sanpham.masp
    JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
    WHERE EXTRACT(YEAR FROM Xuat.ngayxuat) BETWEEN nam_bat_dau AND nam_ket_thuc;

/**Câu 7**/
CREATE FUNCTION danh_sach_sp_theo_hang_va_lua_chon(mahangsx INT, lua_chon INT)
RETURNS TABLE (
    masp INT,
    mahangsx INT,
    tensp VARCHAR(255),
    soluong INT,
    mausac VARCHAR(255),
    giaban FLOAT,
    donvitinh VARCHAR(20),
    mota TEXT
)
AS $$
    SELECT Sanpham.masp, Sanpham.mahangsx, Sanpham.tensp, Sanpham.soluong, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh, Sanpham.mota
    FROM Sanpham
    WHERE Sanpham.mahangsx = mahangsx AND
    (lua_chon = 0 AND Sanpham.masp IN (SELECT masp FROM Nhap)) OR
    (lua_chon = 1 AND Sanpham.masp IN (SELECT masp FROM Xuat));

/**Câu 8**/

