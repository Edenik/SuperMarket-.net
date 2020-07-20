using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Store.Models
{
    public class ProductsDetails
    {
        [Key]
        public int id { get; set; }

        [Required]
        [Column(TypeName = "text")]
        public string productName { get; set; }

        [Required]
        [Column(TypeName = "float")]
        public float price { get; set; }

        [Required]
        [Column(TypeName = "text")]
        public string brand { get; set; }

        [Column(TypeName = "int")]
        public int? weight { get; set; }

        [Required]
        [Column(TypeName = "text")]
        public string unit { get; set; }

        [Required]
        [Column(TypeName = "bit")]
        public bool inSale { get; set; }


        [Column(TypeName = "float")]
        public float? salePrice { get; set; }

        [Column(TypeName = "text")]
        public string saleDescription { get; set; }

        [Required]
        [Column(TypeName = "bit")]
        public bool hasNutritialMark { get; set; }

        [Column(TypeName = "bit")]
        public bool? nutritialSodium { get; set; }

        [Column(TypeName = "bit")]
        public bool? nutritialSugar { get; set; }

        [Column(TypeName = "bit")]
        public bool? nutritialFat { get; set; }

        [Required]
        [Column(TypeName = "text")]
        public string category { get; set; }

        [Required]
        [Column(TypeName = "text")]
        public string subCategory { get; set; }

        [Required]
        [Column(TypeName = "text")]
        public string photoURL { get; set; }

        [Required]
        [Column(TypeName = "text")]
        public string dateAdded { get; set; }

        [Required]
        [Column(TypeName = "text")]
        public string addedByUID { get; set; }

        [Column(TypeName = "text")]
        public string dateEdited { get; set; }

        [Column(TypeName = "text")]
        public string editedByUID { get; set; }
    }
}