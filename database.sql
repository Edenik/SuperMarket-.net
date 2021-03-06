USE [master]
GO
/****** Object:  Database [storeDB]    Script Date: 20-Jul-20 20:11:46 ******/
CREATE DATABASE [storeDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'storeDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\storeDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'storeDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\storeDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [storeDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [storeDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [storeDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [storeDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [storeDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [storeDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [storeDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [storeDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [storeDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [storeDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [storeDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [storeDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [storeDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [storeDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [storeDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [storeDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [storeDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [storeDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [storeDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [storeDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [storeDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [storeDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [storeDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [storeDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [storeDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [storeDB] SET  MULTI_USER 
GO
ALTER DATABASE [storeDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [storeDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [storeDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [storeDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [storeDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [storeDB] SET QUERY_STORE = OFF
GO
USE [storeDB]
GO
/****** Object:  Table [dbo].[category]    Script Date: 20-Jul-20 20:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [text] NOT NULL,
	[dateAdded] [text] NOT NULL,
	[addedByUID] [text] NOT NULL,
	[dateEdited] [text] NULL,
	[editedByUID] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order]    Script Date: 20-Jul-20 20:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fullName] [text] NULL,
	[phone] [text] NULL,
	[email] [text] NULL,
	[city] [text] NULL,
	[adress] [text] NULL,
	[comments] [text] NULL,
	[statusUpdateUID] [text] NULL,
	[statusUpdateDate] [text] NULL,
	[orderStatus] [text] NULL,
	[uid] [text] NULL,
	[orderDiscount] [float] NULL,
	[originalOrderPrice] [float] NULL,
	[orderDate] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orderItem]    Script Date: 20-Jul-20 20:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderItem](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[product_id] [int] NULL,
	[quantity] [float] NULL,
	[order_item_price] [float] NULL,
	[order_item_discount] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 20-Jul-20 20:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[productName] [text] NOT NULL,
	[price] [float] NOT NULL,
	[brand] [text] NOT NULL,
	[weight] [int] NOT NULL,
	[unit] [text] NOT NULL,
	[inSale] [bit] NOT NULL,
	[salePrice] [float] NULL,
	[saleDescription] [text] NULL,
	[hasNutritialMark] [bit] NOT NULL,
	[nutritialSodium] [bit] NULL,
	[nutritialSugar] [bit] NULL,
	[nutritialFat] [bit] NULL,
	[category] [text] NOT NULL,
	[subCategory] [text] NOT NULL,
	[photoURL] [text] NOT NULL,
	[dateAdded] [text] NOT NULL,
	[addedByUID] [text] NOT NULL,
	[dateEdited] [text] NULL,
	[editedByUID] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subcategory]    Script Date: 20-Jul-20 20:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subcategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [text] NOT NULL,
	[dateAdded] [text] NOT NULL,
	[addedByUID] [text] NOT NULL,
	[dateEdited] [text] NULL,
	[editedByUID] [text] NULL,
	[categoryID] [int] NOT NULL,
	[categoryName] [text] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (2, N'משקאות', N'Sat Jul 11 2020 14:26:47 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', N'Sat Jul 11 2020 16:56:40 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2')
INSERT [dbo].[category] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (4, N'פירות, ירקות ופיצוחים', N'Sat Jul 11 2020 17:07:58 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', NULL, NULL)
INSERT [dbo].[category] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (5, N'בשר, עופות ודגים', N'Sat Jul 11 2020 17:08:20 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', N'Mon Jul 13 2020 17:55:57 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3')
INSERT [dbo].[category] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (6, N'לחם, חלב וביצים', N'Sat Jul 11 2020 17:08:35 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', NULL, NULL)
INSERT [dbo].[category] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (7, N'מוצרי יסוד ומכולת', N'Sat Jul 11 2020 17:09:04 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', NULL, NULL)
INSERT [dbo].[category] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (8, N'פארם ותינוקות', N'Sat Jul 11 2020 17:09:18 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', NULL, NULL)
INSERT [dbo].[category] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (9, N'בריאות ואורגני', N'Sat Jul 11 2020 17:09:32 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', NULL, NULL)
INSERT [dbo].[category] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (10, N'ניקיון, חד פעמי ובעלי חיים', N'Sat Jul 11 2020 17:10:36 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', NULL, NULL)
INSERT [dbo].[category] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (11, N'קפואים, סלטים ונקניקים', N'Sat Jul 11 2020 17:10:54 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', NULL, NULL)
SET IDENTITY_INSERT [dbo].[category] OFF
GO
SET IDENTITY_INSERT [dbo].[order] ON 

INSERT [dbo].[order] ([id], [fullName], [phone], [email], [city], [adress], [comments], [statusUpdateUID], [statusUpdateDate], [orderStatus], [uid], [orderDiscount], [originalOrderPrice], [orderDate]) VALUES (1043, N'Eden Phone', N'+972504242429', N'edenik5@gmail.com', N'תל אביב', N'רמברנדט 14', N'', NULL, NULL, N'ההזמנה התקבלה בחנות', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', 8.8500003814697266, 324.73001098632812, N'Thu Jul 16 2020 11:26:02 GMT+0300 (שעון ישראל (קיץ))')
INSERT [dbo].[order] ([id], [fullName], [phone], [email], [city], [adress], [comments], [statusUpdateUID], [statusUpdateDate], [orderStatus], [uid], [orderDiscount], [originalOrderPrice], [orderDate]) VALUES (1044, N'Eden Phone', N'+972504242429', N'edenik5@gmail.com', N'תל אביב', N'רמברנדט 14', N'', NULL, NULL, N'ההזמנה התקבלה בחנות', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', 48.299999237060547, 207.10000610351563, N'Thu Jul 16 2020 19:30:32 GMT+0300 (שעון ישראל (קיץ))')
INSERT [dbo].[order] ([id], [fullName], [phone], [email], [city], [adress], [comments], [statusUpdateUID], [statusUpdateDate], [orderStatus], [uid], [orderDiscount], [originalOrderPrice], [orderDate]) VALUES (1045, N'Eden Phone', N'+972504242429', N'edenik5@gmail.com', N'תל אביב', N'רמברנדט 14', N'', NULL, NULL, N'ההזמנה התקבלה בחנות', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', 38.5, 225.89999389648438, N'Thu Jul 16 2020 19:30:43 GMT+0300 (שעון ישראל (קיץ))')
INSERT [dbo].[order] ([id], [fullName], [phone], [email], [city], [adress], [comments], [statusUpdateUID], [statusUpdateDate], [orderStatus], [uid], [orderDiscount], [originalOrderPrice], [orderDate]) VALUES (1047, N'Jewellery Store', N'+972504242429', N'edenik.com.jewellerystore@gmail.com', N'תל אביב', N'גן העיר', N'שלחו הכלללללללללל', NULL, NULL, N'ההזמנה התקבלה בחנות', N'QnnHbHOi06Z7lzdWgBHvRdbHZcj2', 15.600000381469727, 100, N'Fri Jul 17 2020 08:13:59 GMT+0300 (שעון ישראל (קיץ))')
INSERT [dbo].[order] ([id], [fullName], [phone], [email], [city], [adress], [comments], [statusUpdateUID], [statusUpdateDate], [orderStatus], [uid], [orderDiscount], [originalOrderPrice], [orderDate]) VALUES (1049, N'אדי', N'+972522513805', N'edi@gmail.com', N'haifa', N'haifa', N'', NULL, NULL, N'ההזמנה התקבלה בחנות', N'dtZXxSC3qycRommOg4himxDgXPt1', 84.699996948242188, 288.95001220703125, N'Fri Jul 17 2020 23:04:41 GMT+0300 (שעון ישראל (קיץ))')
INSERT [dbo].[order] ([id], [fullName], [phone], [email], [city], [adress], [comments], [statusUpdateUID], [statusUpdateDate], [orderStatus], [uid], [orderDiscount], [originalOrderPrice], [orderDate]) VALUES (1050, N'Eden Nahum', N'+972504242429', N'edenik5@gmail.com', N'תל אביב', N'רמברנדט 14 דירה 13', N'', NULL, NULL, N'ההזמנה התקבלה בחנות', N'UeH9br8BQjVMneomRnIOXJaCDUE3', 10.899999618530273, 104.40000152587891, N'Sat Jul 18 2020 12:50:07 GMT+0300 (שעון ישראל (קיץ))')
INSERT [dbo].[order] ([id], [fullName], [phone], [email], [city], [adress], [comments], [statusUpdateUID], [statusUpdateDate], [orderStatus], [uid], [orderDiscount], [originalOrderPrice], [orderDate]) VALUES (1051, N'Eden Nahum', N'+972504242429', N'edenik5@gmail.com', N'תל אביב', N'רמברנדט 14 דירה 13', N'', NULL, NULL, N'ההזמנה התקבלה בחנות', N'UeH9br8BQjVMneomRnIOXJaCDUE3', 16.399999618530273, 47.299999237060547, N'Sat Jul 18 2020 21:07:10 GMT+0300 (שעון ישראל (קיץ))')
INSERT [dbo].[order] ([id], [fullName], [phone], [email], [city], [adress], [comments], [statusUpdateUID], [statusUpdateDate], [orderStatus], [uid], [orderDiscount], [originalOrderPrice], [orderDate]) VALUES (1053, N'Test', N'+972504242429', N'test@gmail.com', N'תל אביב', N'גן העיר', N'', NULL, NULL, N'ההזמנה התקבלה בחנות', N'vFMeEVidkCddmMU0voJFHlz98kH2', 16.600000381469727, 54.200000762939453, N'Mon Jul 20 2020 13:37:01 GMT+0300 (שעון ישראל (קיץ))')
INSERT [dbo].[order] ([id], [fullName], [phone], [email], [city], [adress], [comments], [statusUpdateUID], [statusUpdateDate], [orderStatus], [uid], [orderDiscount], [originalOrderPrice], [orderDate]) VALUES (1055, N'משתמש חדש', N'+972545657783', N'gabi@gmail.com', N'ירושליפם', N'ירושליםפ', N'', NULL, NULL, N'ההזמנה התקבלה בחנות', N'EK5cBLOaYIfXeIdqpPr9MGvlLRr1', 9.3000001907348633, 56.790000915527344, N'Mon Jul 20 2020 14:55:06 GMT+0300 (שעון ישראל (קיץ))')
INSERT [dbo].[order] ([id], [fullName], [phone], [email], [city], [adress], [comments], [statusUpdateUID], [statusUpdateDate], [orderStatus], [uid], [orderDiscount], [originalOrderPrice], [orderDate]) VALUES (1042, N'Eden Nahum', N'+972504242429', N'edenik5@gmail.com', N'תל אביב', N'רמברנדט 14', N'', NULL, NULL, N'ההזמנה התקבלה בחנות', N'UeH9br8BQjVMneomRnIOXJaCDUE3', 67.0999984741211, 979.75, N'Wed Jul 15 2020 23:08:31 GMT+0300 (שעון ישראל (קיץ))')
INSERT [dbo].[order] ([id], [fullName], [phone], [email], [city], [adress], [comments], [statusUpdateUID], [statusUpdateDate], [orderStatus], [uid], [orderDiscount], [originalOrderPrice], [orderDate]) VALUES (1046, N'Eden Phone', N'+972504242429', N'edenik5@gmail.com', N'תל אביב', N'רמברנדט 14', N'', NULL, NULL, N'ההזמנה התקבלה בחנות', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', 41.799999237060547, 259.60000610351562, N'Thu Jul 16 2020 19:30:53 GMT+0300 (שעון ישראל (קיץ))')
INSERT [dbo].[order] ([id], [fullName], [phone], [email], [city], [adress], [comments], [statusUpdateUID], [statusUpdateDate], [orderStatus], [uid], [orderDiscount], [originalOrderPrice], [orderDate]) VALUES (1048, N'Eden Nahum', N'+972504242429', N'edenik5@gmail.com', N'תל אביב', N'רמברנדט 14 דירה 13', N'בידוד', N'UeH9br8BQjVMneomRnIOXJaCDUE3', N'Fri Jul 17 2020 23:00:27 GMT+0300 (שעון ישראל (קיץ))', N'ההזמנה בהכנה', N'UeH9br8BQjVMneomRnIOXJaCDUE3', 10.899999618530273, 31.799999237060547, N'Fri Jul 17 2020 22:59:55 GMT+0300 (שעון ישראל (קיץ))')
INSERT [dbo].[order] ([id], [fullName], [phone], [email], [city], [adress], [comments], [statusUpdateUID], [statusUpdateDate], [orderStatus], [uid], [orderDiscount], [originalOrderPrice], [orderDate]) VALUES (1052, N'Eden Nahum', N'+972504242429', N'edenik5@gmail.com', N'תל אביב', N'רמברנדט 14 דירה 13', N'', NULL, NULL, N'ההזמנה התקבלה בחנות', N'UeH9br8BQjVMneomRnIOXJaCDUE3', 2.2000000476837158, 38.900001525878906, N'Sat Jul 18 2020 21:07:22 GMT+0300 (שעון ישראל (קיץ))')
INSERT [dbo].[order] ([id], [fullName], [phone], [email], [city], [adress], [comments], [statusUpdateUID], [statusUpdateDate], [orderStatus], [uid], [orderDiscount], [originalOrderPrice], [orderDate]) VALUES (1054, N'Test', N'+972504242429', N'test@gmail.com', N'תל אביב', N'כשדכשדכש', N'', NULL, NULL, N'ההזמנה התקבלה בחנות', N'vFMeEVidkCddmMU0voJFHlz98kH2', 14.399999618530273, 39.400001525878906, N'Mon Jul 20 2020 13:42:47 GMT+0300 (שעון ישראל (קיץ))')
SET IDENTITY_INSERT [dbo].[order] OFF
GO
SET IDENTITY_INSERT [dbo].[orderItem] ON 

INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2032, 1043, 1014, 1.2000000476837158, 9.8999996185302734, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2033, 1043, 1015, 6, 16.799999237060547, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2034, 1043, 1010, 1.8999999761581421, 10, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2035, 1043, 1009, 1.3999999761581421, 49, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2036, 1043, 1008, 2.2999999523162842, 35, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2037, 1043, 13, 1.5, 15.5, 10)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2038, 1043, 1005, 3, 6.9000000953674316, 6.6999998092651367)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2039, 1044, 1013, 1, 32, 30)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2040, 1044, 1016, 2, 17.899999618530273, 13.899999618530273)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2041, 1044, 1029, 1.3999999761581421, 50, 40)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2042, 1044, 1028, 1, 29.899999618530273, 20)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2043, 1044, 7, 1, 23.899999618530273, 15)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2044, 1044, 13, 1, 15.5, 10)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2045, 1045, 1028, 1, 29.899999618530273, 20)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2046, 1045, 1021, 1, 11.899999618530273, 10.899999618530273)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2047, 1045, 1026, 1, 80, 75)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2048, 1045, 1005, 1, 6.9000000953674316, 6.6999998092651367)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2049, 1045, 1013, 1, 32, 30)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2050, 1045, 1016, 1, 17.899999618530273, 13.899999618530273)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2051, 1045, 13, 1, 15.5, 10)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2052, 1045, 7, 1, 23.899999618530273, 15)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2053, 1045, 17, 1, 7.9000000953674316, 5.9000000953674316)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2062, 1047, 1005, 1, 6.9000000953674316, 6.6999998092651367)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2063, 1047, 13, 1, 15.5, 10)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2064, 1047, 7, 1, 23.899999618530273, 15)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2065, 1047, 1024, 1, 18, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2066, 1047, 1023, 1, 19.899999618530273, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2067, 1047, 1022, 1, 3.9000000953674316, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2068, 1047, 1021, 1, 11.899999618530273, 10.899999618530273)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2071, 1049, 1029, 1.6000000238418579, 50, 40)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2072, 1049, 1028, 1, 29.899999618530273, 20)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2073, 1049, 1021, 1.5, 11.899999618530273, 10.899999618530273)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2074, 1049, 1014, 1, 9.8999996185302734, 8)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2075, 1049, 7, 6, 23.899999618530273, 15)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2076, 1049, 17, 1, 7.9000000953674316, 5.9000000953674316)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2077, 1050, 1008, 1.3999999761581421, 35, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2078, 1050, 1004, 4, 5.9000000953674316, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2079, 1050, 17, 1, 7.9000000953674316, 5.9000000953674316)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2080, 1050, 7, 1, 23.899999618530273, 15)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2081, 1051, 13, 1, 15.5, 10)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2082, 1051, 7, 1, 23.899999618530273, 15)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2083, 1051, 17, 1, 7.9000000953674316, 5.9000000953674316)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2086, 1053, 1005, 1, 6.9000000953674316, 6.6999998092651367)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2087, 1053, 13, 1, 15.5, 10)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2088, 1053, 7, 1, 23.899999618530273, 15)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2089, 1053, 17, 1, 7.9000000953674316, 5.9000000953674316)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2092, 1055, 1021, 1, 11.899999618530273, 10.899999618530273)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2093, 1055, 1005, 3, 6.9000000953674316, 6.6999998092651367)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2094, 1055, 17, 1.1000000238418579, 7.9000000953674316, 5.9000000953674316)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2095, 1055, 13, 1, 15.5, 10)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2084, 1052, 1013, 1, 32, 30)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2085, 1052, 1005, 1, 6.9000000953674316, 6.6999998092651367)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (1999, 1042, 1031, 3, 37.900001525878906, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2000, 1042, 1030, 1.2000000476837158, 80, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2001, 1042, 1027, 3, 8, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2002, 1042, 1033, 4, 13, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2003, 1042, 1024, 4, 18, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2004, 1042, 1023, 1.2999999523162842, 19.899999618530273, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2005, 1042, 1022, 1.1000000238418579, 3.9000000953674316, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2006, 1042, 1017, 1, 5, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2007, 1042, 1018, 1, 10, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2008, 1042, 1019, 1.1000000238418579, 6.9000000953674316, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2009, 1042, 1020, 1, 20.100000381469727, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2010, 1042, 1015, 1, 16.799999237060547, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2011, 1042, 1014, 1, 9.8999996185302734, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2012, 1042, 1012, 1, 7.9000000953674316, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2013, 1042, 1011, 1, 9.8999996185302734, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2014, 1042, 1008, 1, 35, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2015, 1042, 1009, 1, 49, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2016, 1042, 1010, 1, 10, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2017, 1042, 8, 1, 12, 2)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2018, 1042, 1003, 1, 4, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2019, 1042, 1004, 2, 5.9000000953674316, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2020, 1042, 1025, 1, 21.899999618530273, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2021, 1042, 1032, 1, 44, 36)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2022, 1042, 1016, 1, 17.899999618530273, 13.899999618530273)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2023, 1042, 1021, 1, 11.899999618530273, 10.899999618530273)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2024, 1042, 1026, 1.1000000238418579, 80, 75)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2025, 1042, 1028, 2, 29.899999618530273, 20)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2026, 1042, 1029, 1, 50, 40)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2027, 1042, 1013, 1.1000000238418579, 32, 30)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2028, 1042, 1005, 1, 6.9000000953674316, 6.6999998092651367)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2029, 1042, 13, 1, 15.5, 10)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2030, 1042, 7, 1, 23.899999618530273, 15)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2031, 1042, 17, 1, 7.9000000953674316, 5.9000000953674316)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2054, 1046, 1025, 1, 21.899999618530273, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2055, 1046, 1028, 1, 29.899999618530273, 20)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2056, 1046, 7, 1, 23.899999618530273, 15)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2057, 1046, 1004, 1, 5.9000000953674316, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2058, 1046, 1003, 1, 4, 0)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2059, 1046, 1029, 1, 50, 40)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2060, 1046, 1030, 1, 80, 75)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2061, 1046, 1032, 1, 44, 36)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2069, 1048, 7, 1, 23.899999618530273, 15)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2070, 1048, 17, 1, 7.9000000953674316, 5.9000000953674316)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2090, 1054, 7, 1, 23.899999618530273, 15)
INSERT [dbo].[orderItem] ([id], [order_id], [product_id], [quantity], [order_item_price], [order_item_discount]) VALUES (2091, 1054, 13, 1, 15.5, 10)
SET IDENTITY_INSERT [dbo].[orderItem] OFF
GO
SET IDENTITY_INSERT [dbo].[products] ON 

INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (8, N'אפרסק', 12, N'תוצרת הגליל', 1000, N'gr', 0, 2, N'retret', 0, 0, 0, 0, N'פירות, ירקות ופיצוחים', N'פירות', N'https://cdn.pixabay.com/photo/2010/12/13/10/06/food-2279_960_720.jpg', N'Tue Jul 07 2020 17:54:34 GMT+0300 (שעון ישראל (קיץ))', N'WTQ85NhPNGcKqPsQhYnH2fjr4GE2', N'Mon Jul 13 2020 13:52:06 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3')
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (17, N'חציל', 7.9000000953674316, N'תוצרת הארץ', 1000, N'gr', 1, 5.9000000953674316, N'ירידת מחיר', 0, 0, 0, 0, N'פירות, ירקות ופיצוחים', N'ירקות', N'https://cdn.pixabay.com/photo/2018/11/17/15/29/eggplant-3821293_960_720.jpg', N'Tue Jul 07 2020 21:40:49 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', N'Wed Jul 15 2020 02:46:51 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3')
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1003, N'חטיף אגוזי', 4, N'עלית', 45, N'gr', 0, NULL, NULL, 1, NULL, 1, 1, N'מוצרי יסוד ומכולת', N'חטיפים', N'https://storage.googleapis.com/sp-public/product-images/global/3061027/915785/large.jpg', N'Sat Jul 11 2020 11:24:23 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', N'Sun Jul 12 2020 17:53:21 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3')
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1004, N'חטיף שוקולד כריות', 5.9000000953674316, N'קליק', 65, N'gr', 0, NULL, NULL, 1, NULL, 1, 1, N'מוצרי יסוד ומכולת', N'חטיפים', N'https://storage.googleapis.com/sp-public/product-images/global/2835634/1132865/large.jpg', N'Sat Jul 11 2020 11:27:02 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', N'Sun Jul 12 2020 17:53:00 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3')
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (7, N'קורנפלקס', 23.899999618530273, N'post raisin bran', 311, N'gr', 1, 15, N'ירידת מחיר', 1, 0, 1, 0, N'מוצרי יסוד ומכולת', N'חטיפים', N'https://cdn.pixabay.com/photo/2015/01/08/09/24/cornflakes-592609_960_720.jpg', N'Sat Jul 04 2020 13:16:08 GMT+0300 (שעון ישראל (קיץ))', N'WTQ85NhPNGcKqPsQhYnH2fjr4GE2', N'Mon Jul 13 2020 13:53:42 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3')
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (13, N'בננה', 15.5, N'תוצרת הארץ', 1000, N'gr', 1, 10, N'ירידת מחיר', 0, 0, 0, 0, N'פירות, ירקות ופיצוחים', N'פירות', N'https://gcimages.mysupermarket.co.il/products/36/048236.jpg?v=85', N'Tue Jul 07 2020 20:45:44 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', N'Wed Jul 15 2020 02:46:59 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3')
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1005, N'קולה זירו', 6.9000000953674316, N'קוקה קולה', 1500, N'ml', 1, 6.6999998092651367, N'ירידת מחיר', 0, 0, 0, 0, N'משקאות', N'משקאות קלים', N'https://images.unsplash.com/photo-1561758033-48d52648ae8b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60', N'Sat Jul 11 2020 12:19:01 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', N'Thu Jul 16 2020 12:51:54 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2')
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1008, N'תות שדה', 35, N'תוצרת הגליל', 1000, N'gr', 0, NULL, NULL, 0, NULL, NULL, NULL, N'פירות, ירקות ופיצוחים', N'פירות', N'https://cdn.pixabay.com/photo/2016/03/05/21/47/berry-1239097_960_720.jpg', N'Sun Jul 12 2020 18:14:09 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL)
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1009, N'דובדבן אדום טרי', 49, N'ירקן', 1000, N'gr', 0, NULL, NULL, 0, NULL, NULL, NULL, N'פירות, ירקות ופיצוחים', N'פירות', N'https://cdn.pixabay.com/photo/2016/03/05/21/47/berry-1239092_960_720.jpg', N'Sun Jul 12 2020 18:15:38 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL)
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1010, N'שום יבש', 10, N'ירקן', 1000, N'gr', 0, NULL, NULL, 0, NULL, NULL, NULL, N'פירות, ירקות ופיצוחים', N'ירקות', N'https://cdn.pixabay.com/photo/2016/03/05/22/59/bulb-1239422_960_720.jpg', N'Sun Jul 12 2020 18:16:32 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL)
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1011, N'ברוקולי טרי', 9.8999996185302734, N'ירקן', 1000, N'gr', 0, NULL, NULL, 0, NULL, NULL, NULL, N'פירות, ירקות ופיצוחים', N'ירקות', N'https://cdn.pixabay.com/photo/2016/03/05/19/02/broccoli-1238250_960_720.jpg', N'Sun Jul 12 2020 18:17:39 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL)
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1012, N'עוגיות אוראו', 7.9000000953674316, N'אוראו', 200, N'gr', 0, NULL, NULL, 0, NULL, NULL, NULL, N'מוצרי יסוד ומכולת', N'חטיפים', N'https://cdn.pixabay.com/photo/2017/04/04/16/38/cake-2201853_960_720.jpg', N'Sun Jul 12 2020 18:32:21 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL)
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1013, N'אבוקדו', 32, N'ירקן העונה', 1000, N'gr', 1, 30, N'סוף עונת האבוקדו', 0, NULL, NULL, NULL, N'פירות, ירקות ופיצוחים', N'ירקות', N'https://cdn.pixabay.com/photo/2016/03/05/19/03/appetite-1238257_960_720.jpg', N'Sun Jul 12 2020 18:53:14 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL)
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1014, N'תפוח עץ אדום', 9.8999996185302734, N'חרמון', 1000, N'gr', 1, 8, N'ירידת מחיר', 1, 1, 1, 0, N'פירות, ירקות ופיצוחים', N'פירות', N'https://cdn.pixabay.com/photo/2016/03/05/21/43/appetite-1239060_960_720.jpg', N'Sun Jul 12 2020 18:54:32 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', N'Fri Jul 17 2020 23:01:44 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3')
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1015, N'גבינה צהובה', 16.799999237060547, N'העמק', 200, N'gr', 0, NULL, NULL, 0, NULL, NULL, NULL, N'לחם, חלב וביצים', N'גבינות', N'https://cdn.pixabay.com/photo/2016/03/05/19/24/cheese-1238395_960_720.jpg', N'Sun Jul 12 2020 18:56:30 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL)
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1016, N'לחם שיפון כפרי', 17.899999618530273, N'אנג''ל', 750, N'gr', 1, 13.899999618530273, N'ירידת מחיר', 0, NULL, NULL, NULL, N'לחם, חלב וביצים', N'לחם', N'https://images.unsplash.com/photo-1534620808146-d33bb39128b2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60', N'Sun Jul 12 2020 18:58:15 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL)
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1017, N'באגט', 5, N'אנג''ל', 500, N'gr', 0, NULL, NULL, 0, NULL, NULL, NULL, N'לחם, חלב וביצים', N'לחם', N'https://images.unsplash.com/photo-1568471173242-461f0a730452?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60', N'Sun Jul 12 2020 18:59:20 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL)
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1018, N'מארז 10 פיתות', 10, N'אנג''ל', 750, N'ml', 0, NULL, NULL, 0, NULL, NULL, NULL, N'לחם, חלב וביצים', N'לחם', N'https://images.unsplash.com/photo-1521791697570-e1f13d0b81d0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60', N'Sun Jul 12 2020 19:00:53 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL)
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1019, N'תפוז', 6.9000000953674316, N'פירות הצפון', 1000, N'gr', 0, NULL, NULL, 0, NULL, NULL, NULL, N'פירות, ירקות ופיצוחים', N'פירות', N'https://cdn.pixabay.com/photo/2012/12/24/08/40/orange-72321_960_720.jpg', N'Sun Jul 12 2020 19:02:12 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL)
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1020, N'שקדים קלויים', 20.100000381469727, N'קליית גת', 200, N'gr', 0, NULL, NULL, 0, NULL, NULL, NULL, N'פירות, ירקות ופיצוחים', N'פיצוחים ופירות יבשים', N'https://cdn.pixabay.com/photo/2018/03/21/18/23/almonds-3247705_960_720.jpg', N'Sun Jul 12 2020 19:04:28 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL)
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1021, N'פלפל חריף ירוק', 11.899999618530273, N'ירקן הגליל', 1000, N'gr', 1, 10.899999618530273, N'ירידת מחיר', 0, NULL, NULL, NULL, N'פירות, ירקות ופיצוחים', N'ירקות', N'https://cdn.pixabay.com/photo/2016/04/25/21/22/serrano-peppers-1353233_960_720.jpg', N'Sun Jul 12 2020 19:06:17 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL)
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1022, N'גזר ארוז', 3.9000000953674316, N'טעם הטבע', 1000, N'gr', 0, NULL, NULL, 0, NULL, NULL, NULL, N'פירות, ירקות ופיצוחים', N'ירקות', N'https://cdn.pixabay.com/photo/2017/07/31/03/46/carrot-2556382_960_720.jpg', N'Sun Jul 12 2020 19:07:26 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL)
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1023, N'ענבים לבנים', 19.899999618530273, N'טעם הטבע', 1000, N'gr', 0, NULL, NULL, 0, NULL, NULL, NULL, N'פירות, ירקות ופיצוחים', N'פירות', N'https://cdn.pixabay.com/photo/2017/07/24/22/27/grocery-store-2536254_960_720.jpg', N'Sun Jul 12 2020 19:08:31 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL)
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1024, N'12 ביצים אורגניות', 18, N'אורגני ובריא', 12, N'unit', 0, NULL, NULL, 0, NULL, NULL, NULL, N'לחם, חלב וביצים', N'ביצים', N'https://images.unsplash.com/photo-1518569656558-1f25e69d93d7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60', N'Sun Jul 12 2020 19:12:01 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', N'Sun Jul 12 2020 19:14:29 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3')
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1025, N'גרנולה עם פירות', 21.899999618530273, N'שקדייה', 1001, N'gr', 0, NULL, NULL, 1, 1, 1, 0, N'פירות, ירקות ופיצוחים', N'פיצוחים ופירות יבשים', N'https://cdn.pixabay.com/photo/2016/05/06/19/42/muesli-1376575_960_720.jpg', N'Sun Jul 12 2020 19:18:02 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', N'Mon Jul 13 2020 20:43:11 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3')
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1026, N'סטייק טרי', 80, N'אדום טרי', 1000, N'gr', 1, 75, N'חג שמח', 0, NULL, NULL, NULL, N'בשר, עופות ודגים', N'בשר', N'https://images.unsplash.com/photo-1560781290-7dc94c0f8f4f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60', N'Sun Jul 12 2020 19:21:59 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL)
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1027, N'6 ביצים', 8, N'לול בלול', 6, N'unit', 0, NULL, NULL, 0, NULL, NULL, NULL, N'לחם, חלב וביצים', N'ביצים', N'https://images.unsplash.com/photo-1569288052389-dac9b01c9c05?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80', N'Sun Jul 12 2020 19:25:12 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', N'Sun Jul 12 2020 19:49:41 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3')
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1028, N'דג אמנון קפוא', 29.899999618530273, N'דגי תנובה', 1, N'unit', 1, 20, N'ירידת מחיר', 1, NULL, NULL, 1, N'בשר, עופות ודגים', N'דגים', N'https://media.istockphoto.com/photos/closeup-of-fresh-sea-bream-against-white-background-picture-id165637260?k=6&m=165637260&s=612x612&w=0&h=cXZmuEdibTvkvRcVuaDHFdm9Rv3P_5f_kbKzWfGL_6Q=', N'Sun Jul 12 2020 19:41:50 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', N'Mon Jul 13 2020 20:43:36 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3')
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1029, N'פילה סלמון טרי', 50, N'דגי תנובה', 1000, N'gr', 1, 40, N'ירידת מחיר', 0, NULL, NULL, NULL, N'בשר, עופות ודגים', N'דגים', N'https://media.istockphoto.com/photos/large-pink-salmon-fillet-isolated-on-a-white-background-picture-id157641208?k=6&m=157641208&s=612x612&w=0&h=qxWobwCB-7kmE03fV9q7_ydo35QvjkFcyHHgEJXtT08=', N'Sun Jul 12 2020 19:43:14 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL)
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1033, N'חלב', 13, N'תנובת הארץ', 1001, N'ml', 0, NULL, NULL, 0, NULL, NULL, NULL, N'לחם, חלב וביצים', N'חלב ומשקאות חלב', N'https://media.istockphoto.com/photos/gallon-milk-jug-378-l-picture-id1142707573?k=6&m=1142707573&s=612x612&w=0&h=incKrd2sDmhaOVoDn3jIz-lvL5q2ypHySKJhqkL2Eq0=', N'Sun Jul 12 2020 19:51:12 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', N'Mon Jul 20 2020 13:45:30 GMT+0300 (שעון ישראל (קיץ))', N'vFMeEVidkCddmMU0voJFHlz98kH2')
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1030, N'נתח קצבים טרי', 80, N'אדום אדום', 1000, N'gr', 1, 75, N'חג שמח', 0, NULL, NULL, NULL, N'בשר, עופות ודגים', N'בשר', N'https://media.istockphoto.com/photos/raw-grass-fed-flank-steak-picture-id1148054502?k=6&m=1148054502&s=612x612&w=0&h=TGXEuuTfnStbUH39H0J-bUOEv-boSrX3yi44Ef-wMLc=', N'Sun Jul 12 2020 19:44:57 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', N'Thu Jul 16 2020 13:26:19 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2')
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1031, N'בשר טחון טרי', 37.900001525878906, N'קצביה', 1001, N'gr', 1, 36, N'מבצע לחג', 1, NULL, NULL, 1, N'בשר, עופות ודגים', N'בשר', N'https://media.istockphoto.com/photos/raw-ground-beef-picture-id171292868?k=6&m=171292868&s=612x612&w=0&h=jeICrtPDW8lUR2WRjcrkfrWEYurEcua9-4jBI-N2O20=', N'Sun Jul 12 2020 19:46:17 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', N'Mon Jul 20 2020 14:59:41 GMT+0300 (שעון ישראל (קיץ))', N'EK5cBLOaYIfXeIdqpPr9MGvlLRr1')
INSERT [dbo].[products] ([id], [productName], [price], [brand], [weight], [unit], [inSale], [salePrice], [saleDescription], [hasNutritialMark], [nutritialSodium], [nutritialSugar], [nutritialFat], [category], [subCategory], [photoURL], [dateAdded], [addedByUID], [dateEdited], [editedByUID]) VALUES (1032, N'שישיית המבורגרים', 44, N'אדום אדום', 6, N'unit', 1, 36, N'ירידת מחיר', 0, NULL, NULL, NULL, N'בשר, עופות ודגים', N'בשר', N'https://media.istockphoto.com/photos/two-delicious-angus-beef-burgers-isolated-on-a-white-background-picture-id171352175?k=6&m=171352175&s=612x612&w=0&h=aapBS1ulHD8VKP9Q-G25V8JtWCdrPZcMQ8yAAf1bxIs=', N'Sun Jul 12 2020 19:48:03 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL)
SET IDENTITY_INSERT [dbo].[products] OFF
GO
SET IDENTITY_INSERT [dbo].[subcategory] ON 

INSERT [dbo].[subcategory] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID], [categoryID], [categoryName]) VALUES (4, N'משקאות חמים', N'Sat Jul 11 2020 17:05:30 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', N'Wed Jul 15 2020 11:51:05 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', 0, N'משקאות')
INSERT [dbo].[subcategory] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID], [categoryID], [categoryName]) VALUES (2, N'משקאות קלים', N'Sat Jul 11 2020 16:23:06 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', N'Sat Jul 11 2020 17:05:39 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', 2, N'משקאות')
INSERT [dbo].[subcategory] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID], [categoryID], [categoryName]) VALUES (3, N'משקאות חריפים', N'Sat Jul 11 2020 16:24:16 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', N'Wed Jul 15 2020 03:01:54 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', 0, N'משקאות')
INSERT [dbo].[subcategory] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID], [categoryID], [categoryName]) VALUES (6, N'פירות', N'Sat Jul 11 2020 17:32:27 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', NULL, NULL, 4, N'פירות, ירקות ופיצוחים')
INSERT [dbo].[subcategory] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID], [categoryID], [categoryName]) VALUES (7, N'ירקות', N'Sat Jul 11 2020 17:40:33 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', N'Wed Jul 15 2020 20:08:01 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', 2, N'משקאות')
INSERT [dbo].[subcategory] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID], [categoryID], [categoryName]) VALUES (8, N'חטיפים', N'Sun Jul 12 2020 00:31:41 GMT+0300 (שעון ישראל (קיץ))', N'wT8xylbd1ZUNYMagfXnJrdYxGuE2', NULL, NULL, 7, N'מוצרי יסוד ומכולת')
INSERT [dbo].[subcategory] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID], [categoryID], [categoryName]) VALUES (9, N'גבינות', N'Sun Jul 12 2020 18:55:47 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL, 6, N'לחם, חלב וביצים')
INSERT [dbo].[subcategory] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID], [categoryID], [categoryName]) VALUES (10, N'לחם', N'Sun Jul 12 2020 18:56:53 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL, 6, N'לחם, חלב וביצים')
INSERT [dbo].[subcategory] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID], [categoryID], [categoryName]) VALUES (11, N'פיצוחים ופירות יבשים', N'Sun Jul 12 2020 19:03:26 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL, 4, N'פירות, ירקות ופיצוחים')
INSERT [dbo].[subcategory] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID], [categoryID], [categoryName]) VALUES (12, N'ביצים', N'Sun Jul 12 2020 19:09:09 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL, 6, N'לחם, חלב וביצים')
INSERT [dbo].[subcategory] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID], [categoryID], [categoryName]) VALUES (13, N'חלב ומשקאות חלב', N'Sun Jul 12 2020 19:09:35 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL, 6, N'לחם, חלב וביצים')
INSERT [dbo].[subcategory] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID], [categoryID], [categoryName]) VALUES (14, N'בשר', N'Sun Jul 12 2020 19:19:54 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL, 5, N'בשר, עופות ודגים')
INSERT [dbo].[subcategory] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID], [categoryID], [categoryName]) VALUES (15, N'עופות', N'Sun Jul 12 2020 19:20:01 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL, 5, N'בשר, עופות ודגים')
INSERT [dbo].[subcategory] ([id], [name], [dateAdded], [addedByUID], [dateEdited], [editedByUID], [categoryID], [categoryName]) VALUES (16, N'דגים', N'Sun Jul 12 2020 19:20:08 GMT+0300 (שעון ישראל (קיץ))', N'UeH9br8BQjVMneomRnIOXJaCDUE3', NULL, NULL, 5, N'בשר, עופות ודגים')
SET IDENTITY_INSERT [dbo].[subcategory] OFF
GO
USE [master]
GO
ALTER DATABASE [storeDB] SET  READ_WRITE 
GO
