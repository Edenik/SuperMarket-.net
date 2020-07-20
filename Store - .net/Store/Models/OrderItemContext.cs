using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Store.Models
{
    public class OrderItemContext : DbContext
    {
        public OrderItemContext(DbContextOptions<OrderItemContext> options) : base(options)
        {

        }

        public DbSet<OrderItemDetails> orderItem { get; set; }
    }
}
