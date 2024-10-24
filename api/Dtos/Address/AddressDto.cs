using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace api.Dtos.Address
{
    public class AddressDto
    {
        public int Id { get; set; }

        public string DetailedAddress { get; set; } = null!;

        public string? District { get; set; }

        public string? City { get; set; }

        public string? Country { get; set; }

        public DateTime? CreatedAt { get; set; }

        public DateTime? UpdatedAt { get; set; }
    }
}