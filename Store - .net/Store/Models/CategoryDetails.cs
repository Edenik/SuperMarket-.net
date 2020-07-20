using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Store.Models
{
    public class CategoryDetails
    {
        [Key]
        public int id { get; set; }

        [Required]
        [Column(TypeName = "text")]
        public string name { get; set; }

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