using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace Store.Models
{
    public class OrderDetails
    {
        [Key]
        public int id { get; set; }

        [Required]
        [Column(TypeName = "text")]
        public string fullName { get; set; }

        [Required]
        [Column(TypeName = "text")]
        public string phone { get; set; }

        [Required]
        [Column(TypeName = "text")]
        public string email { get; set; }

        [Required]
        [Column(TypeName = "text")]
        public string city { get; set; }

        [Required]
        [Column(TypeName = "text")]
        public string adress { get; set; }


        [Column(TypeName = "text")]
        public string comments { get; set; }

        [Required]
        [Column(TypeName = "text")]
        public string orderStatus { get; set; }

        [Required]
        [Column(TypeName = "text")]
        public string uid { get; set; }

        [Required]
        [Column(TypeName = "float")]
        public float orderDiscount { get; set; }

        [Required]
        [Column(TypeName = "float")]
        public float originalOrderPrice { get; set; }

        [Required]
        [Column(TypeName = "text")]
        public string orderDate { get; set; }

        [Column(TypeName = "text")]
        public string statusUpdateUID { get; set; }

        [Column(TypeName = "text")]
        public string statusUpdateDate { get; set; }
    }
}