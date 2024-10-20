using System;
using System.Collections.Generic;

namespace api.Models;

public partial class ProductItem
{
    public int Id { get; set; }

    public int ProductId { get; set; }

    public int? ColorId { get; set; }

    public int? SizeId { get; set; }

    public decimal OriginalPrice { get; set; }

    public decimal? SalePrice { get; set; }

    public int QuantityInStock { get; set; }

    public virtual Color? Color { get; set; }

    public virtual Product Product { get; set; } = null!;

    public virtual ICollection<ProductImage> ProductImages { get; set; } = new List<ProductImage>();

    public virtual ProductSize? Size { get; set; }
}
