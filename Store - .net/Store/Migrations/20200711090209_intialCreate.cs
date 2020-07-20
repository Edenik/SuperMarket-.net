using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Store.Migrations
{
    public partial class intialCreate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "products",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    productName = table.Column<string>(type: "text", nullable: false),
                    price = table.Column<double>(type: "float", nullable: false),
                    brand = table.Column<string>(type: "text", nullable: false),
                    weight = table.Column<int>(type: "int", nullable: true),
                    unit = table.Column<string>(type: "text", nullable: false),
                    inSale = table.Column<bool>(type: "bit", nullable: false),
                    salePrice = table.Column<double>(type: "float", nullable: true),
                    saleDescription = table.Column<string>(type: "text", nullable: true),
                    hasNutritialMark = table.Column<bool>(type: "bit", nullable: false),
                    nutritialSodium = table.Column<bool>(type: "bit", nullable: true),
                    nutritialSugar = table.Column<bool>(type: "bit", nullable: true),
                    nutritialFat = table.Column<bool>(type: "bit", nullable: true),
                    category = table.Column<string>(type: "text", nullable: false),
                    subCategory = table.Column<string>(type: "text", nullable: false),
                    photoURL = table.Column<string>(type: "text", nullable: false),
                    dateAdded = table.Column<string>(type: "text", nullable: false),
                    addedByUID = table.Column<string>(type: "text", nullable: false),
                    dateEdited = table.Column<string>(type: "text", nullable: true),
                    editedByUID = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_products", x => x.id);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "products");
        }
    }
}
