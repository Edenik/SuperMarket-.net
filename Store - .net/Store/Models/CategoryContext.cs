using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Store.Models
{
    public class CategoryContext : DbContext
    {
        public CategoryContext(DbContextOptions<CategoryContext> options) : base(options)
        {

        }

        public DbSet<CategoryDetails> category { get; set; }
    }
}
