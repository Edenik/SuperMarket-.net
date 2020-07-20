using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Store.Migrations.Category
{
    public partial class intialCreate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "category",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    name = table.Column<string>(type: "text", nullable: false),
                    dateAdded = table.Column<string>(type: "text", nullable: false),
                    addedByUID = table.Column<string>(type: "text", nullable: false),
                    dateEdited = table.Column<string>(type: "text", nullable: true),
                    editedByUID = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_category", x => x.id);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "category");
        }
    }
}
