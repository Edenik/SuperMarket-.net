using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Store.Migrations.OrderItem
{
    public partial class InitialCreate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "orderItem",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    order_id = table.Column<int>(type: "int", nullable: false),
                    product_id = table.Column<int>(type: "int", nullable: false),
                    quantity = table.Column<double>(type: "float", nullable: false),
                    order_item_price = table.Column<double>(type: "float", nullable: false),
                    order_item_discount = table.Column<double>(type: "float", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_orderItem", x => x.id);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "orderItem");
        }
    }
}
