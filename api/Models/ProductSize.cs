using System;
using System.Collections.Generic;

namespace api.Models;

public partial class ProductSize
{
    public int Id { get; set; }

    public string SizeName { get; set; } = null!;

    public virtual ICollection<ProductItem> ProductItems { get; set; } = new List<ProductItem>();
}
