using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.Data;
using api.Dtos.Address;
using api.Mappers;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers
{
    [Route("api/address")]
    [ApiController]
    public class AddressController : ControllerBase
    {
        // In MVC, between Model and Controller are a Mapper and a Dto.
        // Dto is used as a transaction to avoid users from getting data straightly from Model.
        // Mapper is used as an extension for controller, and help controller to connect with dto.  
        private readonly CompanyDbContext _context;
        public AddressController(CompanyDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult GetAll()
        {
            var addresses = _context.Addresses.ToList() // First execution to query sql
            .Select(a => a.ToAddressDto());             // Select is a "dotnet version" of Map -> return a immutable array/list of this address Dto

            return Ok(addresses);
        }

        [HttpGet("{id}")]
        public IActionResult GetById([FromRoute] int id)
        {
            var address = _context.Addresses.Find(id);

            if(address == null)
            {
                return  NotFound();
            }

            return Ok(address.ToAddressDto());
        }

        [HttpPost]
        public IActionResult Create([FromBody] CreateAddressRequestDto addressDto)
        {
            var addressModel = addressDto.ToAddressFromCreateDTO();
            _context.Addresses.Add(addressModel);
            _context.SaveChanges();
            return CreatedAtAction(nameof(GetById), new { id = addressModel.Id }, addressModel.ToAddressDto());
        }
    }
}