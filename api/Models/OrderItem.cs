using System;
using System.Collections.Generic;

namespace api.Models;

public partial class OrderItem
{
    public int Id { get; set; }

    public int ProductId { get; set; }

    public int OrderId { get; set; }

    public decimal Price { get; set; }

    public int Quantity { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual ShopOrder Order { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;
}
