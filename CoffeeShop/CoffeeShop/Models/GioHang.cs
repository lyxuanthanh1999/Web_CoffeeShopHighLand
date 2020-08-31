using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CoffeeShop.Models;
namespace CoffeeShop.Models
{
    public class GioHang
    {
        DataClasses1DataContext data = new DataClasses1DataContext();
        public int maMon { get; set; }
        public string tenMon { get; set; }
        public string anhMon { get; set; }
        public double donGia { get; set; }
        public int soLuong { get; set; }
        public double thanhTien
        {
            get { return soLuong * donGia; }
        }
        public GioHang(int MaMon)
        {
            maMon = MaMon;
            ThucDon mon = data.ThucDons.Single(n => n.MaMon == maMon);
            tenMon = mon.TenMon;
            anhMon = mon.Hinh;
            donGia = double.Parse(mon.Gia.ToString());
            soLuong = 1;

        }
    }
}