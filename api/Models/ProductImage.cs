using System;
using System.Collections.Generic;

namespace api.Models;

public partial class ProductImage
{
    public int Id { get; set; }

    public int ProductItemId { get; set; }

    public string ImageUrl { get; set; } = null!;

    public virtual ProductItem ProductItem { get; set; } = null!;
}
