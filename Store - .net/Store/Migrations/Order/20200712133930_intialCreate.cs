using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Store.Migrations.Order
{
    public partial class intialCreate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "order",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    fullName = table.Column<string>(type: "text", nullable: false),
                    phone = table.Column<string>(type: "text", nullable: false),
                    email = table.Column<string>(type: "text", nullable: false),
                    city = table.Column<string>(type: "text", nullable: false),
                    adress = table.Column<string>(type: "text", nullable: false),
                    comments = table.Column<string>(type: "text", nullable: true),
                    orderStatus = table.Column<string>(type: "text", nullable: false),
                    uid = table.Column<string>(type: "text", nullable: false),
                    orderDiscount = table.Column<double>(type: "float", nullable: false),
                    originalOrderPrice = table.Column<double>(type: "float", nullable: false),
                    orderDate = table.Column<string>(type: "text", nullable: false),
                    statusUpdateUID = table.Column<string>(type: "text", nullable: true),
                    statusUpdateDate = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_order", x => x.id);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "order");
        }
    }
}
