using System;
using System.Collections.Generic;

namespace api.Models;

public partial class ShopOrder
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public DateTime? OrderDate { get; set; }

    public int StatusId { get; set; }

    public string? PaymentMethod { get; set; }

    public int? CouponId { get; set; }

    public int ShippingMethodId { get; set; }

    public int TotalQuantity { get; set; }

    public decimal TotalPrice { get; set; }

    public string? Note { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual Coupon? Coupon { get; set; }

    public virtual ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();

    public virtual ShippingMethod ShippingMethod { get; set; } = null!;

    public virtual OrderStatus Status { get; set; } = null!;

    public virtual ShopUser User { get; set; } = null!;
}
