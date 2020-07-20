﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Store.Models;

namespace Store.Migrations
{
    [DbContext(typeof(ProductsContext))]
    partial class ProductsContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "2.1.14-servicing-32113")
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("Store.Models.ProductsDetails", b =>
                {
                    b.Property<int>("id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("addedByUID")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("brand")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("category")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("dateAdded")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("dateEdited")
                        .HasColumnType("text");

                    b.Property<string>("editedByUID")
                        .HasColumnType("text");

                    b.Property<bool>("hasNutritialMark")
                        .HasColumnType("bit");

                    b.Property<bool>("inSale")
                        .HasColumnType("bit");

                    b.Property<bool?>("nutritialFat")
                        .HasColumnType("bit");

                    b.Property<bool?>("nutritialSodium")
                        .HasColumnType("bit");

                    b.Property<bool?>("nutritialSugar")
                        .HasColumnType("bit");

                    b.Property<string>("photoURL")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<double>("price")
                        .HasColumnType("float");

                    b.Property<string>("productName")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("saleDescription")
                        .HasColumnType("text");

                    b.Property<double?>("salePrice")
                        .HasColumnType("float");

                    b.Property<string>("subCategory")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("unit")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int?>("weight")
                        .HasColumnType("int");

                    b.HasKey("id");

                    b.ToTable("products");
                });
#pragma warning restore 612, 618
        }
    }
}
