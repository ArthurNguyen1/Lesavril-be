using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.Dtos.Address;
using api.Models;

namespace api.Mappers
{
    public static class AddressMapper
    {
        public static AddressDto ToAddressDto(this Address addressModel) //Extension method
        {
            return new AddressDto
            {
                Id = addressModel.Id,

                DetailedAddress = addressModel.DetailedAddress,

                District = addressModel.District,

                City = addressModel.City, 

                Country = addressModel.Country,

                CreatedAt = addressModel.CreatedAt,

                UpdatedAt = addressModel.UpdatedAt
            };
        }
    }
}