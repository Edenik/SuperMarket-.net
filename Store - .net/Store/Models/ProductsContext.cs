using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Store.Models
{
    public class ProductsContext : DbContext
    {
        public ProductsContext(DbContextOptions<ProductsContext> options) : base(options)
        {

        }

        public DbSet<ProductsDetails> products { get; set; }
    }
}
