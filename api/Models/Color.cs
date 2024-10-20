using System;
using System.Collections.Generic;

namespace api.Models;

public partial class Color
{
    public int Id { get; set; }

    public string ColorName { get; set; } = null!;

    public virtual ICollection<ProductItem> ProductItems { get; set; } = new List<ProductItem>();
}
