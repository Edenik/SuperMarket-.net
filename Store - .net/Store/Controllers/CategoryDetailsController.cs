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
    public class CategoryDetailsController : ControllerBase
    {
        private readonly CategoryContext _context;

        public CategoryDetailsController(CategoryContext context)
        {
            _context = context;
        }

        // GET: api/CategoryDetails
        [HttpGet]
        public IEnumerable<CategoryDetails> Getcategory()
        {
            return _context.category;
        }

        // GET: api/CategoryDetails/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetCategoryDetails([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var categoryDetails = await _context.category.FindAsync(id);

            if (categoryDetails == null)
            {
                return NotFound();
            }

            return Ok(categoryDetails);
        }

        // PUT: api/CategoryDetails/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCategoryDetails([FromRoute] int id, [FromBody] CategoryDetails categoryDetails)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != categoryDetails.id)
            {
                return BadRequest();
            }

            _context.Entry(categoryDetails).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CategoryDetailsExists(id))
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

        // POST: api/CategoryDetails
        [HttpPost]
        public async Task<IActionResult> PostCategoryDetails([FromBody] CategoryDetails categoryDetails)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.category.Add(categoryDetails);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCategoryDetails", new { id = categoryDetails.id }, categoryDetails);
        }

        // DELETE: api/CategoryDetails/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCategoryDetails([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var categoryDetails = await _context.category.FindAsync(id);
            if (categoryDetails == null)
            {
                return NotFound();
            }

            _context.category.Remove(categoryDetails);
            await _context.SaveChangesAsync();

            return Ok(categoryDetails);
        }

        private bool CategoryDetailsExists(int id)
        {
            return _context.category.Any(e => e.id == id);
        }
    }
}