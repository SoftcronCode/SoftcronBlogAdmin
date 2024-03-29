USE [master]
GO
/****** Object:  Database [softnew_blog]    Script Date: 11-10-2023 10:38:05 ******/
CREATE DATABASE [softnew_blog]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'softnew_blog', FILENAME = N'C:\Program Files (x86)\Plesk\Databases\MSSQL\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\softnew_blog.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'softnew_blog_log', FILENAME = N'C:\Program Files (x86)\Plesk\Databases\MSSQL\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\softnew_blog_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [softnew_blog] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [softnew_blog].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [softnew_blog] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [softnew_blog] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [softnew_blog] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [softnew_blog] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [softnew_blog] SET ARITHABORT OFF 
GO
ALTER DATABASE [softnew_blog] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [softnew_blog] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [softnew_blog] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [softnew_blog] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [softnew_blog] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [softnew_blog] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [softnew_blog] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [softnew_blog] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [softnew_blog] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [softnew_blog] SET  ENABLE_BROKER 
GO
ALTER DATABASE [softnew_blog] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [softnew_blog] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [softnew_blog] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [softnew_blog] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [softnew_blog] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [softnew_blog] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [softnew_blog] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [softnew_blog] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [softnew_blog] SET  MULTI_USER 
GO
ALTER DATABASE [softnew_blog] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [softnew_blog] SET DB_CHAINING OFF 
GO
ALTER DATABASE [softnew_blog] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [softnew_blog] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [softnew_blog] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [softnew_blog] SET QUERY_STORE = OFF
GO
USE [softnew_blog]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [softnew_blog]
GO
/****** Object:  User [soft_cron]    Script Date: 11-10-2023 10:38:06 ******/
CREATE USER [soft_cron] FOR LOGIN [soft_cron] WITH DEFAULT_SCHEMA=[soft_cron]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [soft_cron]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [soft_cron]
GO
ALTER ROLE [db_datareader] ADD MEMBER [soft_cron]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [soft_cron]
GO
/****** Object:  Schema [csharp]    Script Date: 11-10-2023 10:38:06 ******/
CREATE SCHEMA [csharp]
GO
/****** Object:  Schema [soft_cron]    Script Date: 11-10-2023 10:38:06 ******/
CREATE SCHEMA [soft_cron]
GO
/****** Object:  Table [dbo].[ActivityLog]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityLog](
	[activity_log_id] [bigint] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL,
	[app_user_id] [int] NOT NULL,
	[user_name] [varchar](100) NULL,
	[heading] [varchar](200) NULL,
	[heading_class] [varchar](100) NULL,
	[activity] [varchar](500) NULL,
	[icon] [varchar](100) NULL,
	[icon_class] [varchar](100) NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[modified_on] [datetime] NOT NULL,
	[modified_by] [int] NOT NULL,
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[activity_log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppUserMaster]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppUserMaster](
	[app_user_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL,
	[user_role_master_id] [int] NOT NULL,
	[user_first_name_elm] [varchar](100) NULL,
	[user_last_name] [varchar](100) NULL,
	[user_email_elm] [varchar](500) NULL,
	[user_phone_elm] [varchar](500) NULL,
	[last_login_datetime] [datetime] NULL,
	[user_login_elm] [varchar](500) NULL,
	[user_pass_elm] [varchar](500) NULL,
	[display_name] [nvarchar](100) NULL,
	[profile_pic] [varchar](300) NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[modified_on] [datetime] NOT NULL,
	[modified_by] [int] NOT NULL,
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[app_user_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlogCategory]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogCategory](
	[blog_category_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL,
	[category_name] [varchar](100) NOT NULL,
	[category_type] [varchar](100) NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[modified_on] [datetime] NOT NULL,
	[modified_by] [int] NOT NULL,
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[blog_category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlogMaster]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogMaster](
	[blog_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL,
	[blog_category_id] [int] NOT NULL,
	[category_name] [varchar](100) NULL,
	[blog_title] [varchar](100) NOT NULL,
	[blog_friendly_url] [varchar](200) NULL,
	[blog_description] [varchar](max) NULL,
	[author_name] [varchar](50) NULL,
	[blog_view] [int] NOT NULL,
	[is_published] [bit] NOT NULL,
	[published_on] [datetime] NULL,
	[is_featured] [bit] NOT NULL,
	[blog_tag_id] [varchar](100) NULL,
	[tag_name] [varchar](250) NULL,
	[page_title] [varchar](2000) NULL,
	[meta_Key] [varchar](2000) NULL,
	[meta_description] [varchar](2500) NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[modified_on] [datetime] NOT NULL,
	[modified_by] [int] NOT NULL,
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL,
	[blog_outer_image] [varchar](500) NULL,
	[blog_thumbnail] [varchar](500) NULL,
	[blog_inner_banner_img] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[blog_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CommentMaster]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommentMaster](
	[comment_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL,
	[blog_master_id] [int] NOT NULL,
	[comment_by_user_name] [varchar](100) NOT NULL,
	[blog_comment] [varchar](500) NOT NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[modified_on] [datetime] NOT NULL,
	[modified_by] [int] NOT NULL,
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[comment_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactMaster]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactMaster](
	[contact_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL,
	[full_name] [varchar](100) NOT NULL,
	[email] [varchar](150) NULL,
	[phone_number] [varchar](12) NOT NULL,
	[subject] [varchar](100) NULL,
	[message] [varchar](250) NOT NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[modified_on] [datetime] NOT NULL,
	[modified_by] [int] NOT NULL,
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[contact_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExceptionLog]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExceptionLog](
	[exception_log_id] [bigint] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL,
	[exception_message] [nvarchar](max) NULL,
	[exception_log_date] [datetime] NOT NULL,
	[exception_source] [varchar](250) NULL,
	[user_agent] [varchar](250) NULL,
	[trace_log] [varchar](max) NULL,
	[InputParam] [varchar](max) NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[modified_on] [datetime] NOT NULL,
	[modified_by] [int] NOT NULL,
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[exception_log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GalleryMaster]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GalleryMaster](
	[gallery_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL,
	[name] [varchar](100) NULL,
	[gallery_type] [varchar](100) NULL,
	[image] [nvarchar](250) NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[modified_on] [datetime] NOT NULL,
	[modified_by] [int] NOT NULL,
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[gallery_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HomeContentMaster]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HomeContentMaster](
	[home_content_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL,
	[content_page] [varchar](100) NULL,
	[content_type] [varchar](100) NULL,
	[content_title] [varchar](500) NULL,
	[content_description] [nvarchar](max) NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[modified_on] [datetime] NOT NULL,
	[modified_by] [int] NOT NULL,
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[home_content_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemMaster]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemMaster](
	[item_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL,
	[item_category_id] [int] NOT NULL,
	[category_name] [varchar](100) NULL,
	[item_name] [varchar](100) NOT NULL,
	[item_title] [varchar](100) NOT NULL,
	[item_description] [varchar](max) NULL,
	[item_image] [varchar](500) NULL,
	[item_old_price] [decimal](18, 2) NULL,
	[item_new_price] [decimal](18, 2) NULL,
	[is_discount] [bit] NULL,
	[item_discount_in_percentage] [decimal](18, 2) NULL,
	[item_discount_in_amount] [decimal](18, 2) NULL,
	[item_stock] [int] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[modified_on] [datetime] NOT NULL,
	[modified_by] [int] NOT NULL,
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[item_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MenuMaster]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuMaster](
	[menu_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL,
	[display_name] [nvarchar](200) NULL,
	[page_url] [nvarchar](256) NULL,
	[parent_id] [int] NOT NULL,
	[parent_order] [int] NULL,
	[child_order] [int] NULL,
	[cssclass] [nvarchar](256) NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[modified_on] [datetime] NOT NULL,
	[modified_by] [int] NOT NULL,
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[menu_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaleHeader]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleHeader](
	[guid] [uniqueidentifier] NULL,
	[sale_header_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [varchar](15) NOT NULL,
	[user_id] [int] NOT NULL,
	[user_phone] [varchar](15) NULL,
	[user_email] [varchar](150) NULL,
	[user_address_line_one] [varchar](150) NULL,
	[user_address_line_two] [varchar](150) NULL,
	[user_address_zipcode] [varchar](20) NULL,
	[user_address_city] [varchar](50) NULL,
	[user_address_state] [varchar](50) NULL,
	[sold_items_count] [int] NOT NULL,
	[sold_items_weight] [int] NOT NULL,
	[total_sale] [decimal](10, 2) NULL,
	[total_tax] [decimal](10, 2) NULL,
	[total_shipping] [decimal](10, 2) NULL,
	[shipping_method] [varchar](100) NULL,
	[net_amount] [decimal](10, 2) NULL,
	[paid_amount] [decimal](10, 2) NULL,
	[order_status] [varchar](50) NULL,
	[cancel_reason] [nvarchar](150) NULL,
	[is_coupon_used] [bit] NOT NULL,
	[coupon_code] [varchar](15) NULL,
	[discount_offered] [decimal](10, 2) NULL,
	[is_paid] [bit] NOT NULL,
	[is_dispatched] [bit] NOT NULL,
	[is_cancelled] [bit] NOT NULL,
	[is_delivered] [bit] NOT NULL,
	[payment_detail_id] [int] NOT NULL,
	[isreturn] [bit] NULL,
	[return_amount] [int] NULL,
	[special_delivery_notes] [nvarchar](500) NULL,
	[payment_remarks] [nvarchar](500) NULL,
	[is_active] [bit] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [varchar](25) NULL,
	[modified_on] [datetime] NULL,
	[modified_by] [varchar](25) NULL,
	[user_ip] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[sale_header_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaleItem]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleItem](
	[guid] [uniqueidentifier] NULL,
	[sale_item_id] [int] IDENTITY(1,1) NOT NULL,
	[sale_header_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[item_master_id] [int] NOT NULL,
	[category_master_id] [int] NOT NULL,
	[sku_code] [varchar](15) NULL,
	[item_weight] [int] NOT NULL,
	[selling_rate] [decimal](10, 2) NULL,
	[sold_quantity] [decimal](10, 2) NULL,
	[total_sale_price] [decimal](10, 2) NULL,
	[total_tax_price] [decimal](10, 2) NULL,
	[is_taxable] [bit] NOT NULL,
	[tax_rate_name] [varchar](50) NULL,
	[tax_percentage] [int] NULL,
	[net_total] [decimal](10, 2) NULL,
	[is_return] [bit] NULL,
	[return_amount] [decimal](10, 2) NULL,
	[return_reason] [nvarchar](250) NULL,
	[is_active] [bit] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [varchar](25) NOT NULL,
	[modified_on] [datetime] NOT NULL,
	[modified_by] [varchar](25) NOT NULL,
	[user_ip] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[sale_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocialMediaLinkMaster]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocialMediaLinkMaster](
	[social_media_link_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL,
	[link_name] [varchar](250) NULL,
	[link_url] [varchar](1000) NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[modified_on] [datetime] NOT NULL,
	[modified_by] [int] NOT NULL,
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[social_media_link_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubscribeMaster]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscribeMaster](
	[subscribe_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL,
	[subscribe_email] [varchar](100) NOT NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[modified_on] [datetime] NOT NULL,
	[modified_by] [int] NOT NULL,
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[subscribe_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestimonialMaster]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestimonialMaster](
	[testimonial_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL,
	[name] [varchar](100) NOT NULL,
	[testimonial_title] [varchar](200) NOT NULL,
	[testimonial_description] [nvarchar](max) NULL,
	[image] [nvarchar](250) NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[modified_on] [datetime] NOT NULL,
	[modified_by] [int] NOT NULL,
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[testimonial_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[user_role_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL,
	[user_role_name] [varchar](100) NOT NULL,
	[assigned_menu_ids] [varchar](500) NULL,
	[assigned_feature_ids] [varchar](500) NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[modified_on] [datetime] NOT NULL,
	[modified_by] [int] NOT NULL,
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[user_role_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ActivityLog] ADD  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[ActivityLog] ADD  DEFAULT ((0)) FOR [app_user_id]
GO
ALTER TABLE [dbo].[ActivityLog] ADD  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[ActivityLog] ADD  DEFAULT ((0)) FOR [created_by]
GO
ALTER TABLE [dbo].[ActivityLog] ADD  DEFAULT (getdate()) FOR [modified_on]
GO
ALTER TABLE [dbo].[ActivityLog] ADD  DEFAULT ((0)) FOR [modified_by]
GO
ALTER TABLE [dbo].[ActivityLog] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[AppUserMaster] ADD  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[AppUserMaster] ADD  DEFAULT ((0)) FOR [user_role_master_id]
GO
ALTER TABLE [dbo].[AppUserMaster] ADD  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[AppUserMaster] ADD  DEFAULT ((0)) FOR [created_by]
GO
ALTER TABLE [dbo].[AppUserMaster] ADD  DEFAULT (getdate()) FOR [modified_on]
GO
ALTER TABLE [dbo].[AppUserMaster] ADD  DEFAULT ((0)) FOR [modified_by]
GO
ALTER TABLE [dbo].[AppUserMaster] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[BlogCategory] ADD  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[BlogCategory] ADD  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[BlogCategory] ADD  DEFAULT ((0)) FOR [created_by]
GO
ALTER TABLE [dbo].[BlogCategory] ADD  DEFAULT (getdate()) FOR [modified_on]
GO
ALTER TABLE [dbo].[BlogCategory] ADD  DEFAULT ((0)) FOR [modified_by]
GO
ALTER TABLE [dbo].[BlogCategory] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[BlogMaster] ADD  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[BlogMaster] ADD  DEFAULT ((0)) FOR [blog_category_id]
GO
ALTER TABLE [dbo].[BlogMaster] ADD  DEFAULT ((0)) FOR [blog_view]
GO
ALTER TABLE [dbo].[BlogMaster] ADD  DEFAULT ((0)) FOR [is_published]
GO
ALTER TABLE [dbo].[BlogMaster] ADD  DEFAULT ((0)) FOR [is_featured]
GO
ALTER TABLE [dbo].[BlogMaster] ADD  DEFAULT ((0)) FOR [blog_tag_id]
GO
ALTER TABLE [dbo].[BlogMaster] ADD  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[BlogMaster] ADD  DEFAULT ((0)) FOR [created_by]
GO
ALTER TABLE [dbo].[BlogMaster] ADD  DEFAULT (getdate()) FOR [modified_on]
GO
ALTER TABLE [dbo].[BlogMaster] ADD  DEFAULT ((0)) FOR [modified_by]
GO
ALTER TABLE [dbo].[BlogMaster] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[CommentMaster] ADD  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[CommentMaster] ADD  DEFAULT ((0)) FOR [blog_master_id]
GO
ALTER TABLE [dbo].[CommentMaster] ADD  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[CommentMaster] ADD  DEFAULT ((0)) FOR [created_by]
GO
ALTER TABLE [dbo].[CommentMaster] ADD  DEFAULT (getdate()) FOR [modified_on]
GO
ALTER TABLE [dbo].[CommentMaster] ADD  DEFAULT ((0)) FOR [modified_by]
GO
ALTER TABLE [dbo].[CommentMaster] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[ContactMaster] ADD  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[ContactMaster] ADD  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[ContactMaster] ADD  DEFAULT ((0)) FOR [created_by]
GO
ALTER TABLE [dbo].[ContactMaster] ADD  DEFAULT (getdate()) FOR [modified_on]
GO
ALTER TABLE [dbo].[ContactMaster] ADD  DEFAULT ((0)) FOR [modified_by]
GO
ALTER TABLE [dbo].[ContactMaster] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[ExceptionLog] ADD  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[ExceptionLog] ADD  DEFAULT (getdate()) FOR [exception_log_date]
GO
ALTER TABLE [dbo].[ExceptionLog] ADD  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[ExceptionLog] ADD  DEFAULT ((0)) FOR [created_by]
GO
ALTER TABLE [dbo].[ExceptionLog] ADD  DEFAULT (getdate()) FOR [modified_on]
GO
ALTER TABLE [dbo].[ExceptionLog] ADD  DEFAULT ((0)) FOR [modified_by]
GO
ALTER TABLE [dbo].[ExceptionLog] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[GalleryMaster] ADD  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[GalleryMaster] ADD  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[GalleryMaster] ADD  DEFAULT ((0)) FOR [created_by]
GO
ALTER TABLE [dbo].[GalleryMaster] ADD  DEFAULT (getdate()) FOR [modified_on]
GO
ALTER TABLE [dbo].[GalleryMaster] ADD  DEFAULT ((0)) FOR [modified_by]
GO
ALTER TABLE [dbo].[GalleryMaster] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[HomeContentMaster] ADD  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[HomeContentMaster] ADD  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[HomeContentMaster] ADD  DEFAULT ((0)) FOR [created_by]
GO
ALTER TABLE [dbo].[HomeContentMaster] ADD  DEFAULT (getdate()) FOR [modified_on]
GO
ALTER TABLE [dbo].[HomeContentMaster] ADD  DEFAULT ((0)) FOR [modified_by]
GO
ALTER TABLE [dbo].[HomeContentMaster] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[ItemMaster] ADD  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[ItemMaster] ADD  DEFAULT ((0)) FOR [item_category_id]
GO
ALTER TABLE [dbo].[ItemMaster] ADD  DEFAULT ((0)) FOR [item_old_price]
GO
ALTER TABLE [dbo].[ItemMaster] ADD  DEFAULT ((0)) FOR [item_new_price]
GO
ALTER TABLE [dbo].[ItemMaster] ADD  DEFAULT ((0)) FOR [is_discount]
GO
ALTER TABLE [dbo].[ItemMaster] ADD  DEFAULT ((0)) FOR [item_discount_in_percentage]
GO
ALTER TABLE [dbo].[ItemMaster] ADD  DEFAULT ((0)) FOR [item_discount_in_amount]
GO
ALTER TABLE [dbo].[ItemMaster] ADD  DEFAULT ((0)) FOR [item_stock]
GO
ALTER TABLE [dbo].[ItemMaster] ADD  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[ItemMaster] ADD  DEFAULT ((0)) FOR [created_by]
GO
ALTER TABLE [dbo].[ItemMaster] ADD  DEFAULT (getdate()) FOR [modified_on]
GO
ALTER TABLE [dbo].[ItemMaster] ADD  DEFAULT ((0)) FOR [modified_by]
GO
ALTER TABLE [dbo].[ItemMaster] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[MenuMaster] ADD  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[MenuMaster] ADD  DEFAULT ((0)) FOR [parent_id]
GO
ALTER TABLE [dbo].[MenuMaster] ADD  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[MenuMaster] ADD  DEFAULT ((0)) FOR [created_by]
GO
ALTER TABLE [dbo].[MenuMaster] ADD  DEFAULT (getdate()) FOR [modified_on]
GO
ALTER TABLE [dbo].[MenuMaster] ADD  DEFAULT ((0)) FOR [modified_by]
GO
ALTER TABLE [dbo].[MenuMaster] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[SaleHeader] ADD  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[SaleHeader] ADD  DEFAULT ((0)) FOR [order_id]
GO
ALTER TABLE [dbo].[SaleHeader] ADD  DEFAULT ((0)) FOR [user_id]
GO
ALTER TABLE [dbo].[SaleHeader] ADD  DEFAULT ((0)) FOR [sold_items_count]
GO
ALTER TABLE [dbo].[SaleHeader] ADD  DEFAULT ((0)) FOR [sold_items_weight]
GO
ALTER TABLE [dbo].[SaleHeader] ADD  DEFAULT ((0)) FOR [is_coupon_used]
GO
ALTER TABLE [dbo].[SaleHeader] ADD  DEFAULT ((0)) FOR [is_paid]
GO
ALTER TABLE [dbo].[SaleHeader] ADD  DEFAULT ((0)) FOR [is_dispatched]
GO
ALTER TABLE [dbo].[SaleHeader] ADD  DEFAULT ((0)) FOR [is_cancelled]
GO
ALTER TABLE [dbo].[SaleHeader] ADD  DEFAULT ((0)) FOR [is_delivered]
GO
ALTER TABLE [dbo].[SaleHeader] ADD  DEFAULT ((0)) FOR [payment_detail_id]
GO
ALTER TABLE [dbo].[SaleHeader] ADD  DEFAULT ((0)) FOR [isreturn]
GO
ALTER TABLE [dbo].[SaleHeader] ADD  DEFAULT ((0)) FOR [return_amount]
GO
ALTER TABLE [dbo].[SaleHeader] ADD  DEFAULT ((0)) FOR [is_active]
GO
ALTER TABLE [dbo].[SaleItem] ADD  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[SaleItem] ADD  DEFAULT ((0)) FOR [sale_header_id]
GO
ALTER TABLE [dbo].[SaleItem] ADD  DEFAULT ((0)) FOR [user_id]
GO
ALTER TABLE [dbo].[SaleItem] ADD  DEFAULT ((0)) FOR [item_master_id]
GO
ALTER TABLE [dbo].[SaleItem] ADD  DEFAULT ((0)) FOR [category_master_id]
GO
ALTER TABLE [dbo].[SaleItem] ADD  DEFAULT ((0)) FOR [item_weight]
GO
ALTER TABLE [dbo].[SaleItem] ADD  DEFAULT ((0)) FOR [is_taxable]
GO
ALTER TABLE [dbo].[SaleItem] ADD  DEFAULT ((0)) FOR [is_active]
GO
ALTER TABLE [dbo].[SocialMediaLinkMaster] ADD  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[SocialMediaLinkMaster] ADD  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[SocialMediaLinkMaster] ADD  DEFAULT ((0)) FOR [created_by]
GO
ALTER TABLE [dbo].[SocialMediaLinkMaster] ADD  DEFAULT (getdate()) FOR [modified_on]
GO
ALTER TABLE [dbo].[SocialMediaLinkMaster] ADD  DEFAULT ((0)) FOR [modified_by]
GO
ALTER TABLE [dbo].[SocialMediaLinkMaster] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[SubscribeMaster] ADD  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[SubscribeMaster] ADD  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[SubscribeMaster] ADD  DEFAULT ((0)) FOR [created_by]
GO
ALTER TABLE [dbo].[SubscribeMaster] ADD  DEFAULT (getdate()) FOR [modified_on]
GO
ALTER TABLE [dbo].[SubscribeMaster] ADD  DEFAULT ((0)) FOR [modified_by]
GO
ALTER TABLE [dbo].[SubscribeMaster] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[TestimonialMaster] ADD  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[TestimonialMaster] ADD  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[TestimonialMaster] ADD  DEFAULT ((0)) FOR [created_by]
GO
ALTER TABLE [dbo].[TestimonialMaster] ADD  DEFAULT (getdate()) FOR [modified_on]
GO
ALTER TABLE [dbo].[TestimonialMaster] ADD  DEFAULT ((0)) FOR [modified_by]
GO
ALTER TABLE [dbo].[TestimonialMaster] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[UserRole] ADD  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[UserRole] ADD  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[UserRole] ADD  DEFAULT ((0)) FOR [created_by]
GO
ALTER TABLE [dbo].[UserRole] ADD  DEFAULT (getdate()) FOR [modified_on]
GO
ALTER TABLE [dbo].[UserRole] ADD  DEFAULT ((0)) FOR [modified_by]
GO
ALTER TABLE [dbo].[UserRole] ADD  DEFAULT ((1)) FOR [is_active]
GO
/****** Object:  StoredProcedure [dbo].[sp_DashboardDetail]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_DashboardDetail]
	
	
	
AS
BEGIN

select 'blogcategory' as Name, count(Guid) as Total from BlogCategory where category_type='category'
union all
select 'blog' as Name, count(Guid) as Total from BlogMaster
union all
select 'tag' as Name, count(Guid) as Total from BlogCategory where category_type='tag'
union all
Select 'subscribe' as Name, count(Guid) as Total from SubscribeMaster where is_active=1

End



GO
/****** Object:  StoredProcedure [dbo].[sp_Selectblog]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Selectblog] 
AS
BEGIN
select top 3 * from BlogMaster where is_active=1
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Selectblogcategory]    Script Date: 11-10-2023 10:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[sp_Selectblogcategory]
AS
BEGIN
select distinct max(BlogCategory.blog_category_id)
as blog_category_id ,max(BlogCategory.category_name) as category_name,
count(BlogMaster.blog_category_id) as Total  from BlogCategory left join BlogMaster 
on BlogCategory.blog_category_id=BlogMaster.blog_category_id 
where BlogCategory.category_type='category' and BlogCategory.is_active=1 
group by BlogCategory.blog_category_id
END
GO
USE [master]
GO
ALTER DATABASE [softnew_blog] SET  READ_WRITE 
GO
