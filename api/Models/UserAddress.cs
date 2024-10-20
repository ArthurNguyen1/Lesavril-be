using System;
using System.Collections.Generic;

namespace api.Models;

public partial class UserAddress
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public int AddressId { get; set; }

    public bool? IsDefault { get; set; }

    public string? CustomerName { get; set; }

    public string? PhoneNumber { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual Address Address { get; set; } = null!;

    public virtual ShopUser User { get; set; } = null!;
}
