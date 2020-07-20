using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Store.Models
{
    public class OrderItemDetails
    {
        [Key]
        public int id { get; set; }

        [Required]
        [Column(TypeName = "int")]
        public int order_id { get; set; }

        [Required]
        [Column(TypeName = "int")]
        public int product_id { get; set; }

        [Required]
        [Column(TypeName = "float")]
        public float quantity { get; set; }


        [Required]
        [Column(TypeName = "float")]
        public float order_item_price { get; set; }


        [Required]
        [Column(TypeName = "float")]
        public float order_item_discount { get; set; }
    }
}