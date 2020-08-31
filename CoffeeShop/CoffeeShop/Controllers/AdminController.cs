using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CoffeeShop.Models;
using PagedList;
using PagedList.Mvc;
using System.Web.Security;
using System.IO;
namespace CoffeeShop.Controllers
{
    public class AdminController : Controller
    {
        //
        // GET: /Admin/
        DataClasses1DataContext data = new DataClasses1DataContext();
        private string c;
        public ActionResult Index()
        {
            return View();
        }
        public List<ThucDon> LayThucDon()
        {
            return data.ThucDons.ToList();
        }
        public ActionResult ChinhSua(int? page)
        {
            int pageSize = 5;
            int pageNum = (page ?? 1);

            var listHang = LayThucDon();
            return View(listHang.ToPagedList(pageNum, pageSize));
        }
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(FormCollection f)
        {
            var tenDN = f["TenDN"];
            var password = f["Password"];
            if (string.IsNullOrEmpty(tenDN))
                ViewData["Error1"] = "Tên đăng nhập không được để trống";
            if (string.IsNullOrEmpty(password))
                ViewData["Error2"] = "Mật khẩu không được để trống";
            else
            {
                Admin ad = data.Admins.SingleOrDefault(n => n.UserAdmin == tenDN && n.PassAdmin == password);
                if (ad != null)
                {
                    Session["TaiKhoanAd"] = ad;
                    Session["TaiKhoanTenAd"] = ad.UserAdmin;
                    return RedirectToAction("ChinhSua", "Admin");
                }
                else
                    ViewBag.ThongBao("Tên đăng nhập hoặc mật khẩu không đúng");
            }
            return View();
        }
        public ActionResult LogOut()
        {
            FormsAuthentication.SignOut();
            Session.Abandon(); // it will clear the session at the end of request
            return RedirectToAction("login", "Admin");
        }

        public ActionResult Add()
        {
            var list = new SelectList(data.LoaiMons.ToList().OrderBy(n => n.TenLoaiMon), "MaLoaiMon", "TenLoaiMon");
            ViewBag.MaLoaiMon = list;
            return View();
        }
        [HttpPost]
        public ActionResult Add(ThucDon thucdon, HttpPostedFileBase fileupload)
        {
            if (fileupload == null)
            {
                ViewBag.ThongBao = "Vui Lòng Chọn Ảnh Tải Lên";
                return View();
            }
            else
            {
                if (ModelState.IsValid)
                {
                    var filename = Path.GetFileName(fileupload.FileName);
                    //Luu duong dan file
                    var path = Path.Combine(Server.MapPath("~/Asset/Images"), filename);
                    //kiem tra hinh len chua
                    if (System.IO.File.Exists(path))
                    {
                        ViewBag.ThongBao = "Hình Đã Tồn Tại";
                    }
                    else
                    {
                        //Luu Anh Vao Duong Dan
                        fileupload.SaveAs(path);
                    }
                    thucdon.Hinh = filename;
                    //luu csdl
                    data.ThucDons.InsertOnSubmit(thucdon);
                    data.SubmitChanges();
                }
            }
            return RedirectToAction("Index", "Admin");
        }
        public ActionResult ChiTietThucDon(int id)
        {
            ThucDon thucdon = data.ThucDons.SingleOrDefault(n => n.MaMon == id);
            ViewBag.MaMon = thucdon.MaMon;
            if (thucdon == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(thucdon);
        }
        public ActionResult XoaThucDon(int id)
        {
            ThucDon thucdon = data.ThucDons.SingleOrDefault(n => n.MaMon == id);
            ViewBag.MADT = thucdon.MaMon;
            if (thucdon == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(thucdon);
        }
        [HttpPost, ActionName("XoaThucDon")]
        public ActionResult XacNhanXoa(int id)
        {
            ThucDon thucdon = data.ThucDons.SingleOrDefault(n => n.MaMon == id);
            ViewBag.MADT = thucdon.MaMon;
            if (thucdon == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            data.ThucDons.DeleteOnSubmit(thucdon);
            data.SubmitChanges();
            return RedirectToAction("ChinhSua", "Admin");
        }

        [HttpGet]
        public ActionResult SuaThucDon(int id)
        {
            ThucDon thucdon = data.ThucDons.SingleOrDefault(n => n.MaMon == id);

            if (thucdon == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            //ViewBag.MaMon = new SelectList(data.ThucDons.ToList().OrderBy(n => n.TenMon), "MaMon", "TenMon", thucdon.MaMon);
            ViewBag.MaMon = new SelectList(data.ThucDons, "MaLoaiMon", "TenLoaiMon", thucdon.MaLoaiMon);
            return View(thucdon);
        }
        [HttpPost]
        public ActionResult SuaThucDon(int id, FormCollection f, HttpPostedFileBase fileUp)
        {
            try
            {
                ThucDon td = data.ThucDons.SingleOrDefault(n => n.MaMon == id);
                if (ModelState.IsValid)
                {
                    if (string.IsNullOrEmpty(f["txtTenMon"]))
                    {
                        @ViewData["loi1"] = "Tên Sản Phẩm Không Được Để Trống";
                    }
                    td.TenMon = f["txtTenMon"];
                    if (string.IsNullOrEmpty(f["txtaMoTa"]))
                    {
                        @ViewData["loi2"] = "Mô tả Không Được Để Trống";
                    }
                    td.MoTa = f["txtaMoTa"];
                    if (string.IsNullOrEmpty(f["txtGia"]))
                    {
                        @ViewData["loi3"] = "Giá Không Được Để Trống";
                    }
                    td.Gia = int.Parse(f["txtGia"]);

                    var fileName = Path.GetFileName(fileUp.FileName);// luu ten file
                    var path = Path.Combine(Server.MapPath("~/Asset/Images/"), fileName);//địa chỉ file
                    if (fileUp != null)
                    {
                        fileName = Path.GetFileName(fileUp.FileName);
                        path = Path.Combine(Server.MapPath("~/Asset/Images/"), fileName);
                        fileUp.SaveAs(path);
                    }
                    td.Hinh = fileName;
                    data.SubmitChanges();
                }
                return RedirectToAction("ChinhSua");
            }
            catch
            {
                return RedirectToAction("ChinhSua");
            }
        }
        //[HttpPost]
        //[ValidateInput(false)]
        //public ActionResult SuaThucDon(int id, FormCollection f, HttpPostedFileBase fileUp)
        //{
        //    //ViewBag.MaLoaiMon = new SelectList(data.LoaiMons.ToList().OrderBy(n => n.TenLoaiMon), "MaLoaiMon", "TenLoaiMon");
        //    try
        //    {
        //        ThucDon thucdon = data.ThucDons.SingleOrDefault(n => n.MaMon == id);
        //        if (fileUp == null)
        //        {
        //            ViewBag.ThongBao = "Hãy chọn ảnh cho sản phẩm";
        //            return View();
        //        }
        //        else
        //        {
        //            if (ModelState.IsValid)
        //            {
        //                var fileName = Path.GetFileName(fileUp.FileName);
        //                var path = Path.Combine(Server.MapPath("~/Asset/images/"), fileName);
        //                if (System.IO.File.Exists(path))
        //                    ViewBag.ThongBao = "Hình ảnh đã tồn tại";
        //                else
        //                    fileUp.SaveAs(path);
        //                thucdon.Hinh = fileName;
        //                UpdateModel(thucdon);
        //                data.SubmitChanges();
        //            }
        //            return RedirectToAction("ChiTietThucDon", "Admin");
        //        }
        //    }
        //}
    }
}
