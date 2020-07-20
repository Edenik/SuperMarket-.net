using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Store.Models;

namespace Store.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderDetailsController : ControllerBase
    {
        private readonly OrderContext _context;

        public OrderDetailsController(OrderContext context)
        {
            _context = context;
        }

        // GET: api/OrderDetails
        [HttpGet]
        public IEnumerable<OrderDetails> Getorder()
        {
            return _context.order;
        }

        // GET: api/OrderDetails/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetOrderDetails([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var orderDetails = await _context.order.FindAsync(id);

            if (orderDetails == null)
            {
                return NotFound();
            }

            return Ok(orderDetails);
        }

        // PUT: api/OrderDetails/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutOrderDetails([FromRoute] int id, [FromBody] OrderDetails orderDetails)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != orderDetails.id)
            {
                return BadRequest();
            }

            _context.Entry(orderDetails).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!OrderDetailsExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/OrderDetails
        [HttpPost]
        public async Task<IActionResult> PostOrderDetails([FromBody] OrderDetails orderDetails)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.order.Add(orderDetails);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetOrderDetails", new { id = orderDetails.id }, orderDetails);
        }

        // DELETE: api/OrderDetails/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteOrderDetails([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var orderDetails = await _context.order.FindAsync(id);
            if (orderDetails == null)
            {
                return NotFound();
            }

            _context.order.Remove(orderDetails);
            await _context.SaveChangesAsync();

            return Ok(orderDetails);
        }

        private bool OrderDetailsExists(int id)
        {
            return _context.order.Any(e => e.id == id);
        }
    }
}