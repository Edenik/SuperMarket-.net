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
    public class OrderItemDetailsController : ControllerBase
    {
        private readonly OrderItemContext _context;

        public OrderItemDetailsController(OrderItemContext context)
        {
            _context = context;
        }

        // GET: api/OrderItemDetails?orderId=2
        [HttpGet]
        public IEnumerable<OrderItemDetails> GetproductByOrderId([FromQuery] int orderId)
        {
            if (orderId > 0)
            {
                return _context.orderItem.Where(e => e.order_id == orderId);
            }
            return _context.orderItem;
        }

        // GET: api/OrderItemDetails/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetOrderItemDetails([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var orderItemDetails = await _context.orderItem.FindAsync(id);

            if (orderItemDetails == null)
            {
                return NotFound();
            }

            return Ok(orderItemDetails);
        }

        // PUT: api/OrderItemDetails/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutOrderItemDetails([FromRoute] int id, [FromBody] OrderItemDetails orderItemDetails)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != orderItemDetails.id)
            {
                return BadRequest();
            }

            _context.Entry(orderItemDetails).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!OrderItemDetailsExists(id))
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

        // POST: api/OrderItemDetails
        [HttpPost]
        public async Task<IActionResult> PostOrderItemDetails([FromBody] OrderItemDetails orderItemDetails)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.orderItem.Add(orderItemDetails);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetOrderItemDetails", new { id = orderItemDetails.id }, orderItemDetails);
        }

        // DELETE: api/OrderItemDetails/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteOrderItemDetails([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var orderItemDetails = await _context.orderItem.FindAsync(id);
            if (orderItemDetails == null)
            {
                return NotFound();
            }

            _context.orderItem.Remove(orderItemDetails);
            await _context.SaveChangesAsync();

            return Ok(orderItemDetails);
        }

        private bool OrderItemDetailsExists(int id)
        {
            return _context.orderItem.Any(e => e.id == id);
        }
    }
}