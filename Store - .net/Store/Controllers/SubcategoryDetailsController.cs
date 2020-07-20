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
    public class SubcategoryDetailsController : ControllerBase
    {
        private readonly SubcategoryContext _context;

        public SubcategoryDetailsController(SubcategoryContext context)
        {
            _context = context;
        }
        /*
        // GET: api/SubcategoryDetails
        [HttpGet]
        public IEnumerable<SubcategoryDetails> Getsubcategory()
        {
            return _context.subcategory;
        }
        */

        // GET: api/SubcategoryDetails?categoryId=2
        [HttpGet]
        public IEnumerable<SubcategoryDetails> GetSubcategoriesByCategoryID([FromQuery] int categoryId)
        {
            if (categoryId > 0)
            {
                return _context.subcategory.Where(e => e.categoryID == categoryId);
            }
            return _context.subcategory;
        }


        // GET: api/SubcategoryDetails/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetSubcategoryDetails([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var subcategoryDetails = await _context.subcategory.FindAsync(id);

            if (subcategoryDetails == null)
            {
                return NotFound();
            }

            return Ok(subcategoryDetails);
        }

        // PUT: api/SubcategoryDetails/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSubcategoryDetails([FromRoute] int id, [FromBody] SubcategoryDetails subcategoryDetails)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != subcategoryDetails.id)
            {
                return BadRequest();
            }

            _context.Entry(subcategoryDetails).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SubcategoryDetailsExists(id))
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

        // POST: api/SubcategoryDetails
        [HttpPost]
        public async Task<IActionResult> PostSubcategoryDetails([FromBody] SubcategoryDetails subcategoryDetails)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.subcategory.Add(subcategoryDetails);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetSubcategoryDetails", new { id = subcategoryDetails.id }, subcategoryDetails);
        }

        // DELETE: api/SubcategoryDetails/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSubcategoryDetails([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var subcategoryDetails = await _context.subcategory.FindAsync(id);
            if (subcategoryDetails == null)
            {
                return NotFound();
            }

            _context.subcategory.Remove(subcategoryDetails);
            await _context.SaveChangesAsync();

            return Ok(subcategoryDetails);
        }

        private bool SubcategoryDetailsExists(int id)
        {
            return _context.subcategory.Any(e => e.id == id);
        }
    }
}