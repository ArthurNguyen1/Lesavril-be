using System;
using System.Collections.Generic;

namespace api.Models;

public partial class Address
{
    public int Id { get; set; }

    public string DetailedAddress { get; set; } = null!;

    public string? District { get; set; }

    public string? City { get; set; }

    public string? Country { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual ICollection<UserAddress> UserAddresses { get; set; } = new List<UserAddress>();
}
