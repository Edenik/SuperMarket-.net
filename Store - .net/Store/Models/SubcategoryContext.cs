using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Store.Models
{
    public class SubcategoryContext: DbContext
    {
        public SubcategoryContext(DbContextOptions<SubcategoryContext> options) : base(options)
    {

    }

    public DbSet<SubcategoryDetails> subcategory { get; set; }
}
}
