using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Store.Models;

namespace Store.Models
{
    public class OrderContext : DbContext
    {
        public OrderContext(DbContextOptions<OrderContext> options) : base(options)
        {

        }

        public DbSet<OrderDetails> order { get; set; }
    }
}
