USE [master]
GO
/****** Object:  Database [softcron]    Script Date: 05/07/2022 11:41:27 ******/
CREATE DATABASE [softcron]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'softcron', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\softcron.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'softcron_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\softcron_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [softcron] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [softcron].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [softcron] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [softcron] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [softcron] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [softcron] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [softcron] SET ARITHABORT OFF 
GO
ALTER DATABASE [softcron] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [softcron] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [softcron] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [softcron] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [softcron] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [softcron] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [softcron] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [softcron] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [softcron] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [softcron] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [softcron] SET  DISABLE_BROKER 
GO
ALTER DATABASE [softcron] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [softcron] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [softcron] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [softcron] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [softcron] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [softcron] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [softcron] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [softcron] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [softcron] SET  MULTI_USER 
GO
ALTER DATABASE [softcron] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [softcron] SET DB_CHAINING OFF 
GO
ALTER DATABASE [softcron] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [softcron] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [softcron]
GO
/****** Object:  StoredProcedure [dbo].[sp_DashboardDetail]    Script Date: 05/07/2022 11:41:27 ******/
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
/****** Object:  Table [dbo].[ActivityLog]    Script Date: 05/07/2022 11:41:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ActivityLog](
	[activity_log_id] [bigint] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[app_user_id] [int] NOT NULL DEFAULT ((0)),
	[user_name] [varchar](100) NULL,
	[heading] [varchar](200) NULL,
	[heading_class] [varchar](100) NULL,
	[activity] [varchar](500) NULL,
	[icon] [varchar](100) NULL,
	[icon_class] [varchar](100) NULL,
	[created_on] [datetime] NOT NULL DEFAULT (getdate()),
	[created_by] [int] NOT NULL DEFAULT ((0)),
	[modified_on] [datetime] NOT NULL DEFAULT (getdate()),
	[modified_by] [int] NOT NULL DEFAULT ((0)),
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[activity_log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AppUserMaster]    Script Date: 05/07/2022 11:41:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AppUserMaster](
	[app_user_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[user_role_master_id] [int] NOT NULL DEFAULT ((0)),
	[user_first_name_elm] [varchar](100) NULL,
	[user_last_name] [varchar](100) NULL,
	[user_email_elm] [varchar](500) NULL,
	[user_phone_elm] [varchar](500) NULL,
	[last_login_datetime] [datetime] NULL,
	[user_login_elm] [varchar](500) NULL,
	[user_pass_elm] [varchar](500) NULL,
	[display_name] [nvarchar](100) NULL,
	[profile_pic] [varchar](300) NULL,
	[created_on] [datetime] NOT NULL DEFAULT (getdate()),
	[created_by] [int] NOT NULL DEFAULT ((0)),
	[modified_on] [datetime] NOT NULL DEFAULT (getdate()),
	[modified_by] [int] NOT NULL DEFAULT ((0)),
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[app_user_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BlogCategory]    Script Date: 05/07/2022 11:41:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BlogCategory](
	[blog_category_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[category_name] [varchar](100) NOT NULL,
	[category_type] [varchar](100) NULL,
	[created_on] [datetime] NOT NULL DEFAULT (getdate()),
	[created_by] [int] NOT NULL DEFAULT ((0)),
	[modified_on] [datetime] NOT NULL DEFAULT (getdate()),
	[modified_by] [int] NOT NULL DEFAULT ((0)),
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[blog_category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BlogMaster]    Script Date: 05/07/2022 11:41:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BlogMaster](
	[blog_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[blog_category_id] [int] NOT NULL DEFAULT ((0)),
	[category_name] [varchar](100) NULL,
	[blog_title] [varchar](100) NOT NULL,
	[blog_friendly_url] [varchar](200) NULL,
	[blog_description] [varchar](max) NULL,
	[blog_outer_image] [varchar](500) NULL,
	[blog_thumbnail] [varchar](500) NULL,
	[blog_inner_banner_img] [varchar](500) NULL,
	[author_name] [varchar](50) NULL,
	[blog_view] [int] NOT NULL DEFAULT ((0)),
	[is_published] [bit] NOT NULL DEFAULT ((0)),
	[published_on] [datetime] NULL,
	[is_featured] [bit] NOT NULL DEFAULT ((0)),
	[blog_tag_id] [varchar](100) NULL DEFAULT ((0)),
	[tag_name] [varchar](250) NULL,
	[page_title] [varchar](2000) NULL,
	[meta_Key] [varchar](2000) NULL,
	[meta_description] [varchar](2500) NULL,
	[created_on] [datetime] NOT NULL DEFAULT (getdate()),
	[created_by] [int] NOT NULL DEFAULT ((0)),
	[modified_on] [datetime] NOT NULL DEFAULT (getdate()),
	[modified_by] [int] NOT NULL DEFAULT ((0)),
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[blog_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CommentMaster]    Script Date: 05/07/2022 11:41:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CommentMaster](
	[comment_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[blog_master_id] [int] NOT NULL DEFAULT ((0)),
	[comment_by_user_name] [varchar](100) NOT NULL,
	[user_image] [varchar](500) NULL,
	[blog_comment] [varchar](500) NOT NULL,
	[created_on] [datetime] NOT NULL DEFAULT (getdate()),
	[created_by] [int] NOT NULL DEFAULT ((0)),
	[modified_on] [datetime] NOT NULL DEFAULT (getdate()),
	[modified_by] [int] NOT NULL DEFAULT ((0)),
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[comment_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContactMaster]    Script Date: 05/07/2022 11:41:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContactMaster](
	[contact_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[full_name] [varchar](100) NOT NULL,
	[email] [varchar](150) NULL,
	[phone_number] [varchar](12) NOT NULL,
	[subject] [varchar](100) NULL,
	[message] [varchar](250) NOT NULL,
	[created_on] [datetime] NOT NULL DEFAULT (getdate()),
	[created_by] [int] NOT NULL DEFAULT ((0)),
	[modified_on] [datetime] NOT NULL DEFAULT (getdate()),
	[modified_by] [int] NOT NULL DEFAULT ((0)),
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[contact_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ExceptionLog]    Script Date: 05/07/2022 11:41:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GalleryMaster]    Script Date: 05/07/2022 11:41:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GalleryMaster](
	[gallery_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[name] [varchar](100) NULL,
	[gallery_type] [varchar](100) NULL,
	[image] [nvarchar](250) NULL,
	[created_on] [datetime] NOT NULL DEFAULT (getdate()),
	[created_by] [int] NOT NULL DEFAULT ((0)),
	[modified_on] [datetime] NOT NULL DEFAULT (getdate()),
	[modified_by] [int] NOT NULL DEFAULT ((0)),
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[gallery_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HomeContentMaster]    Script Date: 05/07/2022 11:41:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HomeContentMaster](
	[home_content_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[content_page] [varchar](100) NULL,
	[content_type] [varchar](100) NULL,
	[content_title] [varchar](500) NULL,
	[content_description] [nvarchar](max) NULL,
	[created_on] [datetime] NOT NULL DEFAULT (getdate()),
	[created_by] [int] NOT NULL DEFAULT ((0)),
	[modified_on] [datetime] NOT NULL DEFAULT (getdate()),
	[modified_by] [int] NOT NULL DEFAULT ((0)),
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[home_content_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ItemMaster]    Script Date: 05/07/2022 11:41:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ItemMaster](
	[item_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[item_category_id] [int] NOT NULL DEFAULT ((0)),
	[category_name] [varchar](100) NULL,
	[item_name] [varchar](100) NOT NULL,
	[item_title] [varchar](100) NOT NULL,
	[item_description] [varchar](max) NULL,
	[item_image] [varchar](500) NULL,
	[item_old_price] [decimal](18, 2) NULL DEFAULT ((0)),
	[item_new_price] [decimal](18, 2) NULL DEFAULT ((0)),
	[is_discount] [bit] NULL DEFAULT ((0)),
	[item_discount_in_percentage] [decimal](18, 2) NULL DEFAULT ((0)),
	[item_discount_in_amount] [decimal](18, 2) NULL DEFAULT ((0)),
	[item_stock] [int] NOT NULL DEFAULT ((0)),
	[created_on] [datetime] NOT NULL DEFAULT (getdate()),
	[created_by] [int] NOT NULL DEFAULT ((0)),
	[modified_on] [datetime] NOT NULL DEFAULT (getdate()),
	[modified_by] [int] NOT NULL DEFAULT ((0)),
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[item_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MenuMaster]    Script Date: 05/07/2022 11:41:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MenuMaster](
	[menu_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[display_name] [nvarchar](200) NULL,
	[page_url] [nvarchar](256) NULL,
	[parent_id] [int] NOT NULL DEFAULT ((0)),
	[parent_order] [int] NULL,
	[child_order] [int] NULL,
	[cssclass] [nvarchar](256) NULL,
	[created_on] [datetime] NOT NULL DEFAULT (getdate()),
	[created_by] [int] NOT NULL DEFAULT ((0)),
	[modified_on] [datetime] NOT NULL DEFAULT (getdate()),
	[modified_by] [int] NOT NULL DEFAULT ((0)),
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[menu_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SocialMediaLinkMaster]    Script Date: 05/07/2022 11:41:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SocialMediaLinkMaster](
	[social_media_link_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[link_name] [varchar](250) NULL,
	[link_url] [varchar](1000) NULL,
	[created_on] [datetime] NOT NULL DEFAULT (getdate()),
	[created_by] [int] NOT NULL DEFAULT ((0)),
	[modified_on] [datetime] NOT NULL DEFAULT (getdate()),
	[modified_by] [int] NOT NULL DEFAULT ((0)),
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[social_media_link_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SubscribeMaster]    Script Date: 05/07/2022 11:41:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SubscribeMaster](
	[subscribe_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[subscribe_email] [varchar](100) NOT NULL,
	[created_on] [datetime] NOT NULL DEFAULT (getdate()),
	[created_by] [int] NOT NULL DEFAULT ((0)),
	[modified_on] [datetime] NOT NULL DEFAULT (getdate()),
	[modified_by] [int] NOT NULL DEFAULT ((0)),
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[subscribe_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TestimonialMaster]    Script Date: 05/07/2022 11:41:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TestimonialMaster](
	[testimonial_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[name] [varchar](100) NOT NULL,
	[testimonial_title] [varchar](200) NOT NULL,
	[testimonial_description] [nvarchar](max) NULL,
	[image] [nvarchar](250) NULL,
	[created_on] [datetime] NOT NULL DEFAULT (getdate()),
	[created_by] [int] NOT NULL DEFAULT ((0)),
	[modified_on] [datetime] NOT NULL DEFAULT (getdate()),
	[modified_by] [int] NOT NULL DEFAULT ((0)),
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[testimonial_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 05/07/2022 11:41:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserRole](
	[user_role_master_id] [int] IDENTITY(1,1) NOT NULL,
	[guid] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[user_role_name] [varchar](100) NOT NULL,
	[assigned_menu_ids] [varchar](500) NULL,
	[assigned_feature_ids] [varchar](500) NULL,
	[created_on] [datetime] NOT NULL DEFAULT (getdate()),
	[created_by] [int] NOT NULL DEFAULT ((0)),
	[modified_on] [datetime] NOT NULL DEFAULT (getdate()),
	[modified_by] [int] NOT NULL DEFAULT ((0)),
	[user_ip] [varchar](20) NULL,
	[is_active] [bit] NOT NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[user_role_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[ActivityLog] ON 

INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (1, N'567d3465-648d-4c4f-9d15-ddc111a3abec', 1, N'deepak', N'Comment Added', N'text-success', N'comment added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-13 15:25:17.533' AS DateTime), 0, CAST(N'2022-04-13 15:25:17.533' AS DateTime), 0, N'::1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (2, N'6175994f-3d83-4a86-8d9c-1664aecbf414', 1, N'Deepak', N'User Registeration', N'text-success', N'Account created from app', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-13 16:24:48.173' AS DateTime), 0, CAST(N'2022-04-13 16:24:48.190' AS DateTime), 0, N'::1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (3, N'4241c710-6baf-4590-8388-704235d95a0f', 1, N'deepaksaini307@gmail.com', N'Subscriber Added', N'text-success', N'Subscriber added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-13 17:08:28.053' AS DateTime), 0, CAST(N'2022-04-13 17:08:28.053' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (4, N'6ff2af4f-5957-4c25-abce-66417421037f', 1, N'Deepak', N'User Registeration', N'text-success', N'Account created from app', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-14 14:41:49.867' AS DateTime), 0, CAST(N'2022-04-14 14:41:49.867' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (5, N'57639527-2880-4344-82c0-70572547452c', 1, N'guest', N'Comment Added', N'text-success', N'comment added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-14 17:05:37.513' AS DateTime), 0, CAST(N'2022-04-14 17:05:37.513' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (6, N'97f5e711-9af8-4e06-aa32-b9566fb2444e', 1, N'guest', N'Comment Added', N'text-success', N'comment added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-14 17:34:05.120' AS DateTime), 0, CAST(N'2022-04-14 17:34:05.120' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (7, N'66f65315-1e30-4ad0-b88a-dcbc7abf0718', 1, N'guest', N'Comment Added', N'text-success', N'comment added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-14 17:36:38.650' AS DateTime), 0, CAST(N'2022-04-14 17:36:38.650' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (8, N'e515b105-1438-436e-8069-329057d8aa0b', 1, N'guest', N'Comment Added', N'text-success', N'comment added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-14 17:43:54.037' AS DateTime), 0, CAST(N'2022-04-14 17:43:54.037' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (9, N'6725d9c2-7b67-4220-930d-e6dab616371e', 1, N'guest', N'Comment Added', N'text-success', N'comment added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-14 17:51:34.763' AS DateTime), 0, CAST(N'2022-04-14 17:51:34.763' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (10, N'7a5406b8-abe7-4ae1-ae3f-1690ed9b2315', 1, N'guest', N'Comment Added', N'text-success', N'comment added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-14 17:53:20.480' AS DateTime), 0, CAST(N'2022-04-14 17:53:20.480' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (11, N'1a2ce9eb-ac81-487e-a227-012105d8c158', 1, N'guest', N'Comment Added', N'text-success', N'comment added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-14 17:57:26.197' AS DateTime), 0, CAST(N'2022-04-14 17:57:26.197' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (12, N'd97b6b5e-62d8-4dc8-9b54-4eeea2e79daf', 1, N'Deepak Saini', N'Support Added', N'text-success', N'Support added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-14 18:00:44.430' AS DateTime), 0, CAST(N'2022-04-14 18:00:44.430' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (13, N'179ee820-608d-4927-b6a1-e50ab0fbd840', 1, N'Deepak', N'Support Added', N'text-success', N'Support added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-14 18:44:58.100' AS DateTime), 0, CAST(N'2022-04-14 18:44:58.100' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (14, N'abf62383-15ba-48ae-aa74-72bc4eab74d4', 1, N'Karan', N'Support Added', N'text-success', N'Support added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-15 11:07:42.907' AS DateTime), 0, CAST(N'2022-04-15 11:07:42.907' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (15, N'0c4864ab-e8f4-400b-9427-bb201c9a4eae', 1, N'deepaksaini307@gmail.com', N'Subscriber Added', N'text-success', N'Subscriber added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-15 11:26:39.847' AS DateTime), 0, CAST(N'2022-04-15 11:26:39.847' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (16, N'de9c75ad-84e5-47ed-961b-75c6d48c3a63', 1, N'Deepak Saini', N'User Registeration', N'text-success', N'Account created from app', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-15 12:34:55.363' AS DateTime), 0, CAST(N'2022-04-15 12:34:55.363' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (17, N'153fc248-0c0f-4625-8b68-a06c1f43abe6', 1, N'Deepak Saini', N'User Registeration', N'text-success', N'Account created from app', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-15 12:46:41.497' AS DateTime), 1, CAST(N'2022-04-15 12:46:41.497' AS DateTime), 1, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (18, N'ee42f2fb-e989-4800-8851-2327de69146d', 1, N'karankatyal1998@gmail.com', N'Subscriber Added', N'text-success', N'Subscriber added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-15 12:59:35.610' AS DateTime), 0, CAST(N'2022-04-15 12:59:35.610' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (19, N'e89ed723-c713-4722-9916-2949985a149f', 1, N'Deepak Saini', N'User Registeration', N'text-success', N'Account created from app', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-15 18:10:10.617' AS DateTime), 1, CAST(N'2022-04-15 18:10:10.617' AS DateTime), 1, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (20, N'47ea16f1-d2b1-4fc0-b8a4-41d94e6df350', 1, N'guest', N'Comment Added', N'text-success', N'comment added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-15 21:05:17.070' AS DateTime), 0, CAST(N'2022-04-15 21:05:17.070' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (21, N'5696fc2c-cef2-4dba-a175-b72791e27ce8', 1, N'Karan', N'Support Added', N'text-success', N'Support added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-18 11:13:28.650' AS DateTime), 0, CAST(N'2022-04-18 11:13:28.650' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (22, N'e26daf6f-7c1f-47b3-b53c-04264cf1cb65', 1, N'Deepak Saini', N'BlogMaster Published', N'text-success', N'BlogMaster Id-2 published successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-18 11:42:29.583' AS DateTime), 1, CAST(N'2022-04-18 11:42:29.583' AS DateTime), 1, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (23, N'80882cc1-c97a-4825-ad72-46342ae388be', 1, N'Deepak', N'Support Added', N'text-success', N'Support added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-18 12:18:31.057' AS DateTime), 0, CAST(N'2022-04-18 12:18:31.057' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (24, N'6d4ee117-3a25-466f-b5b6-3244d5a32f1b', 1, N'Deepak Saini', N'User Registeration', N'text-success', N'Account created from app', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-18 13:30:45.367' AS DateTime), 1, CAST(N'2022-04-18 13:30:45.367' AS DateTime), 1, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (25, N'5ae42fe1-f1b0-4be3-b35d-7ac98d05a56d', 1, N'Deepak Saini', N'User Registeration', N'text-success', N'Account created from app', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-18 13:41:50.017' AS DateTime), 1, CAST(N'2022-04-18 13:41:50.017' AS DateTime), 1, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (26, N'fc556b15-5cd3-407e-a54a-5ae3e651fc6b', 1, N'deepaksaini307@gmail.com', N'Subscriber Added', N'text-success', N'Subscriber added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-18 13:45:55.310' AS DateTime), 0, CAST(N'2022-04-18 13:45:55.310' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (27, N'4d577a89-4f17-4b7e-8674-805427cb6d9d', 1, N'guest', N'Comment Added', N'text-success', N'comment added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-18 14:50:11.810' AS DateTime), 0, CAST(N'2022-04-18 14:50:11.810' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (28, N'40c7d5a6-609e-4718-9731-a2c322ce2665', 1, N'Deepak', N'Support Added', N'text-success', N'Support added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-19 11:27:31.323' AS DateTime), 0, CAST(N'2022-04-19 11:27:31.323' AS DateTime), 0, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (29, N'4436a0c4-a0ba-4d10-a75a-d2307396b0d7', 1, N'Deepak Saini', N'BlogMaster Update', N'text-success', N'BlogMaster Id-2 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-19 16:50:46.427' AS DateTime), 1, CAST(N'2022-04-19 16:50:46.427' AS DateTime), 1, N'172.16.80.1', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (30, N'f253983f-c9ea-4433-b545-ea3d3bef33c2', 1, N'Deepak Saini', N'BlogMaster Update', N'text-success', N'BlogMaster Id-2 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-20 17:22:16.230' AS DateTime), 1, CAST(N'2022-04-20 17:22:16.230' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (31, N'10f96fa3-5f23-4ad3-87ce-c369ca359db1', 1, N'Deepak Saini', N'BlogMaster Set Featured', N'text-success', N'BlogMaster Id-2 set featured successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-20 17:48:13.700' AS DateTime), 1, CAST(N'2022-04-20 17:48:13.700' AS DateTime), 1, N'202.9.120.61', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (32, N'2b9e3446-f012-4708-aee3-2fab84ac48ad', 1, N'Deepak Saini', N'BlogMaster Set Featured', N'text-success', N'BlogMaster Id-2 set featured successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-20 17:48:24.310' AS DateTime), 1, CAST(N'2022-04-20 17:48:24.310' AS DateTime), 1, N'202.9.120.61', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (33, N'ff76bb2b-9b47-4e08-a9a3-814794ccae14', 1, N'Deepak Saini', N'BlogMaster Update', N'text-success', N'BlogMaster Id-1 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-20 22:51:10.647' AS DateTime), 1, CAST(N'2022-04-20 22:51:10.647' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (34, N'36123b81-166b-49b0-a420-17c5a673d844', 1, N'Deepak Saini', N'BlogMaster Update', N'text-success', N'BlogMaster Id-1 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-20 22:52:08.693' AS DateTime), 1, CAST(N'2022-04-20 22:52:08.693' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (35, N'4135a9ad-c07e-453e-9340-28d4d5d8dca9', 1, N'Deepak Saini', N'BlogMaster Update', N'text-success', N'BlogMaster Id-1 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-20 23:40:11.360' AS DateTime), 1, CAST(N'2022-04-20 23:40:11.360' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (36, N'c36cafe5-bf38-44ba-a895-c1bdd73acfdb', 1, N'Deepak Saini', N'BlogMaster Update', N'text-success', N'BlogMaster Id-1 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 11:33:15.410' AS DateTime), 1, CAST(N'2022-04-25 11:33:15.410' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (37, N'ae7e9713-3c04-4f3d-8afe-d4b7bff48b89', 1, N'Deepak Saini', N'BlogMaster Update', N'text-success', N'BlogMaster Id-1 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 11:33:25.160' AS DateTime), 1, CAST(N'2022-04-25 11:33:25.160' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (38, N'990f1a60-2454-4026-b5a0-0684e42b7b96', 1, N'Deepak', N'User Registeration', N'text-success', N'Account created from app', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 11:35:05.070' AS DateTime), 1, CAST(N'2022-04-25 11:35:05.070' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (39, N'bd329cb9-64b2-421f-93d5-971030294f28', 1, N'Deepak', N'BlogMaster Set Featured', N'text-success', N'BlogMaster Id-3 set featured successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 11:35:17.523' AS DateTime), 1, CAST(N'2022-04-25 11:35:17.523' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (40, N'830e9c4d-8893-40a0-8ada-e43d4bc45ca2', 1, N'Deepak', N'BlogMaster Set Featured', N'text-success', N'BlogMaster Id-3 set featured successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 11:35:28.260' AS DateTime), 1, CAST(N'2022-04-25 11:35:28.260' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (41, N'dc5acd78-d52c-4cc2-8357-4552ded356b8', 1, N'Deepak', N'BlogMaster Update', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 11:46:21.680' AS DateTime), 1, CAST(N'2022-04-25 11:46:21.680' AS DateTime), 1, N'202.9.120.61', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (42, N'f941d9d2-ee25-4e8f-8096-d6c6f123c8e0', 1, N'Deepak', N'BlogMaster Update', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 11:49:00.780' AS DateTime), 1, CAST(N'2022-04-25 11:49:00.780' AS DateTime), 1, N'202.9.120.61', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (43, N'0e88815b-ca8d-413f-967e-31e69896ecba', 1, N'Deepak Saini', N'BlogMaster Update', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 11:50:19.050' AS DateTime), 1, CAST(N'2022-04-25 11:50:19.050' AS DateTime), 1, N'202.9.120.61', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (44, N'da80ca6e-bdf2-4a99-b811-6603f39254ba', 1, N'Deepak Saini', N'BlogMaster Published', N'text-success', N'BlogMaster Id-3 published successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 13:12:02.037' AS DateTime), 1, CAST(N'2022-04-25 13:12:02.037' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (45, N'5af8c25a-1c5c-47d6-9365-498a61710918', 1, N'Deepak Saini', N'BlogMaster Published', N'text-success', N'BlogMaster Id-3 published successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 13:12:07.067' AS DateTime), 1, CAST(N'2022-04-25 13:12:07.067' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (46, N'c8de7160-e3d0-41d1-be72-e1906d647f1b', 1, N'Deepak Saini', N'BlogMaster Update', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 13:12:33.067' AS DateTime), 1, CAST(N'2022-04-25 13:12:33.067' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (47, N'7232c694-ea4d-4ba9-898e-970121c42d09', 1, N'Deepak Saini', N'BlogMaster Published', N'text-success', N'BlogMaster Id-3 published successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 13:13:28.460' AS DateTime), 1, CAST(N'2022-04-25 13:13:28.460' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (48, N'0d54884c-7b7a-4b27-b0be-a48231930885', 1, N'Deepak Saini', N'BlogMaster Status Updated', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 13:21:17.690' AS DateTime), 1, CAST(N'2022-04-25 13:21:17.690' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (49, N'2205af76-3402-49ee-896e-95bb67f47403', 1, N'Deepak Saini', N'BlogMaster Update', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 13:32:40.993' AS DateTime), 1, CAST(N'2022-04-25 13:32:40.993' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (50, N'1316aabe-f6d1-4ce1-a703-eb794a3b908e', 1, N'Deepak Saini', N'BlogMaster Update', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 13:33:58.870' AS DateTime), 1, CAST(N'2022-04-25 13:33:58.870' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (51, N'52414e0e-f576-4fa2-a830-27783ea53856', 1, N'Deepak Saini', N'BlogMaster Update', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 13:35:03.403' AS DateTime), 1, CAST(N'2022-04-25 13:35:03.403' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (52, N'984c2516-5b94-41ea-9692-51c49d70b70b', 1, N'Deepak Saini', N'BlogMaster Update', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 13:46:17.033' AS DateTime), 1, CAST(N'2022-04-25 13:46:17.033' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (53, N'361647e7-f045-4b9d-8c1a-a0e77b2d188d', 1, N'Deepak Saini', N'BlogMaster Update', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 13:48:01.227' AS DateTime), 1, CAST(N'2022-04-25 13:48:01.227' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (54, N'c982d739-b59f-4c5f-aa72-4b10d25f6001', 1, N'guest', N'Comment Added', N'text-success', N'comment added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 14:37:33.647' AS DateTime), 0, CAST(N'2022-04-25 14:37:33.647' AS DateTime), 0, N'202.9.120.61', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (55, N'05b9cdb3-9513-4eb3-8c80-c5e23365906e', 1, N'Deepak Saini', N'BlogMaster Published', N'text-success', N'BlogMaster Id-3 published successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 16:18:08.440' AS DateTime), 1, CAST(N'2022-04-25 16:18:08.440' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (56, N'ed4dd037-a11a-4ee9-9c84-ad7280deaa79', 1, N'Deepak Saini', N'BlogMaster Published', N'text-success', N'BlogMaster Id-3 published successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 16:18:26.267' AS DateTime), 1, CAST(N'2022-04-25 16:18:26.267' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (57, N'0beae213-fbb5-4b33-aa69-64e0e3280a31', 1, N'Deepak Saini', N'BlogMaster Status Updated', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 18:29:13.553' AS DateTime), 1, CAST(N'2022-04-25 18:29:13.553' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (58, N'6cb51c57-7909-4909-859d-46b9001603e3', 1, N'Deepak Saini', N'BlogMaster Status Updated', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 18:29:17.290' AS DateTime), 1, CAST(N'2022-04-25 18:29:17.290' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (59, N'141b48f7-59c4-4c83-bd1c-a0c7f923eeb4', 1, N'Deepak Saini', N'BlogMaster Status Updated', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 18:29:26.273' AS DateTime), 1, CAST(N'2022-04-25 18:29:26.273' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (60, N'4db6b279-b821-45f7-9a22-387b8a5353fe', 1, N'Deepak Saini', N'BlogMaster Status Updated', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-25 18:29:34.040' AS DateTime), 1, CAST(N'2022-04-25 18:29:34.040' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (61, N'd8bd9d01-b5a9-4a72-ac32-1f1bc56fddf2', 1, N'Deepak Saini', N'BlogMaster Published', N'text-success', N'BlogMaster Id-3 published successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-26 10:41:03.050' AS DateTime), 1, CAST(N'2022-04-26 10:41:03.050' AS DateTime), 1, N'202.9.120.61', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (62, N'7fda378b-8074-4221-b63c-32567a0a0eba', 1, N'Deepak Saini', N'BlogMaster Published', N'text-success', N'BlogMaster Id-3 published successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-26 10:41:50.223' AS DateTime), 1, CAST(N'2022-04-26 10:41:50.223' AS DateTime), 1, N'202.9.120.61', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (63, N'1608304b-720a-4187-92bf-40ab2bfa6e5e', 1, N'Deepak Saini', N'BlogMaster Status Updated', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-26 11:08:07.147' AS DateTime), 1, CAST(N'2022-04-26 11:08:07.147' AS DateTime), 1, N'202.9.120.61', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (64, N'35285176-02e6-4d7c-a699-70e28396bd35', 1, N'Deepak Saini', N'BlogMaster Status Updated', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-26 11:08:13.757' AS DateTime), 1, CAST(N'2022-04-26 11:08:13.757' AS DateTime), 1, N'202.9.120.61', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (65, N'48b2ad62-a892-45dd-8a35-70d825d67b3c', 1, N'Deepak Saini', N'BlogMaster Set Featured', N'text-success', N'BlogMaster Id-3 set featured successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-26 11:08:39.820' AS DateTime), 1, CAST(N'2022-04-26 11:08:39.820' AS DateTime), 1, N'202.9.120.61', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (66, N'de7379e7-c4d5-4c39-b7a7-fe62f56c819c', 1, N'Deepak Saini', N'BlogMaster Set Featured', N'text-success', N'BlogMaster Id-3 set featured successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-26 11:08:45.430' AS DateTime), 1, CAST(N'2022-04-26 11:08:45.430' AS DateTime), 1, N'202.9.120.61', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (67, N'1da83cf3-e619-4245-807a-79832fc2e84d', 1, N'Deepak Saini', N'BlogMaster Status Updated', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-26 12:05:36.260' AS DateTime), 1, CAST(N'2022-04-26 12:05:36.260' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (68, N'd5dbc2a2-2d8a-466d-9cdd-b38dd3b0a8da', 1, N'Deepak Saini', N'BlogMaster Status Updated', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-26 12:05:41.637' AS DateTime), 1, CAST(N'2022-04-26 12:05:41.637' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (69, N'1c56e72d-be08-4b2b-a09a-a83ffe46e4e5', 1, N'Deepak Saini', N'BlogMaster Published', N'text-success', N'BlogMaster Id-1 published successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-26 17:21:59.077' AS DateTime), 1, CAST(N'2022-04-26 17:21:59.077' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (70, N'062f183e-3b9d-46a0-b6f8-082ff863ce37', 1, N'guest', N'Comment Added', N'text-success', N'comment added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-26 17:59:36.697' AS DateTime), 0, CAST(N'2022-04-26 17:59:36.697' AS DateTime), 0, N'103.206.103.199', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (71, N'8e7f6b0a-15c7-40f5-9c65-e2fd85361467', 1, N'jogi@gmail.com', N'Subscriber Added', N'text-success', N'Subscriber added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-27 17:07:15.357' AS DateTime), 0, CAST(N'2022-04-27 17:07:15.357' AS DateTime), 0, N'103.206.103.199', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (72, N'06a89567-70e3-41f0-b009-b956fa3d45bd', 1, N'joginder@test.com', N'Subscriber Added', N'text-success', N'Subscriber added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-27 20:19:30.263' AS DateTime), 0, CAST(N'2022-04-27 20:19:30.263' AS DateTime), 0, N'202.9.120.142', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (73, N'793433c5-a0b0-4535-94f3-03d288f8c2a8', 1, N'guest', N'Comment Added', N'text-success', N'comment added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-27 20:23:13.783' AS DateTime), 0, CAST(N'2022-04-27 20:23:13.783' AS DateTime), 0, N'202.9.120.142', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (74, N'9ce0858c-a631-4558-b6cd-1bb0f6042b81', 1, N'Joginder', N'Support Added', N'text-success', N'Support added from web', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-27 20:24:42.630' AS DateTime), 0, CAST(N'2022-04-27 20:24:42.630' AS DateTime), 0, N'202.9.120.142', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (75, N'4d9dfa43-74d1-43e8-bc0b-528fd9ae9232', 1, N'Joginder M', N'User Registeration', N'text-success', N'Account created from app', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-27 20:37:26.943' AS DateTime), 1, CAST(N'2022-04-27 20:37:26.943' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (76, N'ac08a20d-7969-431b-91ad-b3a45ba78f2b', 1, N'Joginder M', N'BlogMaster Published', N'text-success', N'BlogMaster Id-4 published successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-27 20:38:14.447' AS DateTime), 1, CAST(N'2022-04-27 20:38:14.447' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (77, N'9cbc9880-df92-4487-9181-8223770dcc9b', 1, N'Deepak Saini', N'BlogMaster Set Featured', N'text-success', N'BlogMaster Id-3 set featured successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-28 11:48:04.290' AS DateTime), 1, CAST(N'2022-04-28 11:48:04.290' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (78, N'7352c079-5bcd-4744-bf0d-d4b59a61cd30', 1, N'Deepak Saini', N'BlogMaster Set Featured', N'text-success', N'BlogMaster Id-3 set featured successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-28 11:48:39.510' AS DateTime), 1, CAST(N'2022-04-28 11:48:39.510' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (79, N'cc72474f-3fab-4038-8149-82b6a1c7b42f', 1, N'Joginder M', N'BlogMaster Status Updated', N'text-success', N'BlogMaster Id-4 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-28 12:05:21.270' AS DateTime), 1, CAST(N'2022-04-28 12:05:21.270' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (80, N'1e1d0751-4c95-4a9a-a328-ae1da43dabfb', 1, N'Joginder M', N'BlogMaster Status Updated', N'text-success', N'BlogMaster Id-4 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-28 12:06:31.497' AS DateTime), 1, CAST(N'2022-04-28 12:06:31.497' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (81, N'5ac17152-0c60-4cf9-a2a8-c78eb5262b39', 1, N'Joginder M', N'BlogMaster Status Updated', N'text-success', N'BlogMaster Id-4 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-28 12:59:18.767' AS DateTime), 1, CAST(N'2022-04-28 12:59:18.767' AS DateTime), 1, N'103.206.103.199', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (82, N'9dba2a75-9545-451b-a53d-32cb18bd840f', 1, N'Joginder M', N'BlogMaster Status Updated', N'text-success', N'BlogMaster Id-4 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-28 13:14:45.040' AS DateTime), 1, CAST(N'2022-04-28 13:14:45.040' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (83, N'ef5877eb-58dd-4bd3-8e45-94925762affd', 1, N'Deepak Saini', N'BlogMaster Status Updated', N'text-success', N'BlogMaster Id-3 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-29 10:13:29.217' AS DateTime), 1, CAST(N'2022-04-29 10:13:29.217' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (84, N'a36137cc-1e41-4ec9-a82a-bc5921eaa487', 1, N'Joginder M', N'BlogMaster Status Updated', N'text-success', N'BlogMaster Id-4 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-30 11:02:12.520' AS DateTime), 1, CAST(N'2022-04-30 11:02:12.520' AS DateTime), 1, N'103.206.103.199', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (85, N'456e9d11-1e55-42c1-8ef5-450ba5445b81', 1, N'Joginder M', N'BlogMaster Status Updated', N'text-success', N'BlogMaster Id-4 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-30 11:04:46.633' AS DateTime), 1, CAST(N'2022-04-30 11:04:46.633' AS DateTime), 1, N'103.206.103.199', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (86, N'4a95e061-5232-4d87-90cd-b0f21f04b6c8', 1, N'Joginder M', N'BlogMaster Status Updated', N'text-success', N'BlogMaster Id-4 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-30 12:44:03.510' AS DateTime), 1, CAST(N'2022-04-30 12:44:03.510' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[ActivityLog] ([activity_log_id], [guid], [app_user_id], [user_name], [heading], [heading_class], [activity], [icon], [icon_class], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (87, N'2c26fd92-934e-4500-b3eb-0ed973e446f6', 1, N'Joginder M', N'BlogMaster Status Updated', N'text-success', N'BlogMaster Id-4 updated successfully', N'fa fa-user', N'timeline-icon themed-background-emerald themed-border-emerald', CAST(N'2022-04-30 12:44:37.170' AS DateTime), 1, CAST(N'2022-04-30 12:44:37.170' AS DateTime), 1, N'103.108.220.238', 0)
SET IDENTITY_INSERT [dbo].[ActivityLog] OFF
SET IDENTITY_INSERT [dbo].[AppUserMaster] ON 

INSERT [dbo].[AppUserMaster] ([app_user_master_id], [guid], [user_role_master_id], [user_first_name_elm], [user_last_name], [user_email_elm], [user_phone_elm], [last_login_datetime], [user_login_elm], [user_pass_elm], [display_name], [profile_pic], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (1, N'813e2408-9678-49df-b27b-9102d5e2044c', 1, N'Anju', N'Kumari', N'healing2peace@gmail.com', N'7206769157', NULL, N'healing2peace@gmail.com', N'12341234', N'Anju Kumari', NULL, CAST(N'2022-04-14 17:02:07.483' AS DateTime), 1, CAST(N'2022-04-14 17:02:07.483' AS DateTime), 1, NULL, 1)
INSERT [dbo].[AppUserMaster] ([app_user_master_id], [guid], [user_role_master_id], [user_first_name_elm], [user_last_name], [user_email_elm], [user_phone_elm], [last_login_datetime], [user_login_elm], [user_pass_elm], [display_name], [profile_pic], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (3, N'a1240497-7736-4a8b-8560-31e8ad246066', 2, N'Ashok', N'Khatri', N'ashok001@gmail.com', N'9812090942', NULL, N'ashok001@gmail.com', N'12341234', N'Ashok Khatri', N'', CAST(N'2022-04-18 10:47:15.630' AS DateTime), 1, CAST(N'2022-04-18 10:47:15.630' AS DateTime), 1, NULL, 1)
INSERT [dbo].[AppUserMaster] ([app_user_master_id], [guid], [user_role_master_id], [user_first_name_elm], [user_last_name], [user_email_elm], [user_phone_elm], [last_login_datetime], [user_login_elm], [user_pass_elm], [display_name], [profile_pic], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (4, N'9c789949-7636-4b84-a59c-fb67cd02d440', 4, N'Pankaj ABC', N'Garg', N'pankaj01@gmail.com', N'0123345678', NULL, N'pankaj01@gmail.com', N'12345678', N'Pankaj ABC Garg', N'', CAST(N'2022-04-26 17:19:58.677' AS DateTime), 1, CAST(N'2022-04-26 17:19:58.677' AS DateTime), 1, NULL, 1)
INSERT [dbo].[AppUserMaster] ([app_user_master_id], [guid], [user_role_master_id], [user_first_name_elm], [user_last_name], [user_email_elm], [user_phone_elm], [last_login_datetime], [user_login_elm], [user_pass_elm], [display_name], [profile_pic], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (5, N'9934a99b-0253-4a42-8bb0-783d8af1dab7', 5, N'Jogi', N'Malho', N'shines@gmail.com', N'9181998181', NULL, N'shines@gmail.com', N'12341234', N'Jogi Malho', N'', CAST(N'2022-04-27 20:41:50.993' AS DateTime), 1, CAST(N'2022-04-27 20:41:50.993' AS DateTime), 1, NULL, 1)
SET IDENTITY_INSERT [dbo].[AppUserMaster] OFF
SET IDENTITY_INSERT [dbo].[BlogCategory] ON 

INSERT [dbo].[BlogCategory] ([blog_category_id], [guid], [category_name], [category_type], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (1, N'69143067-0da5-4487-9ea1-4b4183aff5b0', N'Parental', N'category', CAST(N'2022-04-15 10:24:58.787' AS DateTime), 1, CAST(N'2022-04-15 10:24:58.787' AS DateTime), 1, NULL, 1)
INSERT [dbo].[BlogCategory] ([blog_category_id], [guid], [category_name], [category_type], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (2, N'b5e77796-64ba-48b3-9d06-9b510436d7e1', N'Home Decors', N'category', CAST(N'2022-04-15 10:27:29.600' AS DateTime), 1, CAST(N'2022-04-15 10:27:29.600' AS DateTime), 1, NULL, 1)
INSERT [dbo].[BlogCategory] ([blog_category_id], [guid], [category_name], [category_type], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (3, N'85ee8530-31fc-401e-bfa6-ff3dc99a64ab', N'Child Care', N'category', CAST(N'2022-04-15 12:03:23.193' AS DateTime), 1, CAST(N'2022-04-15 12:03:23.193' AS DateTime), 1, NULL, 1)
INSERT [dbo].[BlogCategory] ([blog_category_id], [guid], [category_name], [category_type], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (4, N'309dd20c-d85b-484c-a564-3bc1c4fdc08e', N'Tag One', N'tag', CAST(N'2022-04-15 16:20:56.263' AS DateTime), 1, CAST(N'2022-04-15 16:20:56.263' AS DateTime), 1, NULL, 1)
INSERT [dbo].[BlogCategory] ([blog_category_id], [guid], [category_name], [category_type], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (5, N'429b1b14-cae2-4a3f-b8e1-0d603bc23380', N'Tag Two', N'tag', CAST(N'2022-04-15 16:21:04.780' AS DateTime), 1, CAST(N'2022-04-15 16:21:04.780' AS DateTime), 1, NULL, 1)
INSERT [dbo].[BlogCategory] ([blog_category_id], [guid], [category_name], [category_type], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (6, N'6b4f4d41-32b6-48f1-9dc6-b96659a6789a', N'Tag Three', N'tag', CAST(N'2022-04-15 16:21:12.323' AS DateTime), 1, CAST(N'2022-04-15 16:21:12.323' AS DateTime), 1, NULL, 1)
INSERT [dbo].[BlogCategory] ([blog_category_id], [guid], [category_name], [category_type], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (7, N'9a2bc076-4013-422b-afe7-9ea182edd8bb', N'Tag Four', N'tag', CAST(N'2022-04-20 17:30:57.927' AS DateTime), 1, CAST(N'2022-04-20 17:30:57.927' AS DateTime), 1, NULL, 1)
INSERT [dbo].[BlogCategory] ([blog_category_id], [guid], [category_name], [category_type], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (8, N'f38ff423-1029-44c2-9dc0-bf549832ec23', N'Spiritual', N'category', CAST(N'2022-04-27 20:47:41.520' AS DateTime), 1, CAST(N'2022-04-27 20:47:41.520' AS DateTime), 1, NULL, 0)
INSERT [dbo].[BlogCategory] ([blog_category_id], [guid], [category_name], [category_type], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (9, N'43a4fab9-fc67-4985-bc80-7d1619f20c97', N'Clothes', N'ic', CAST(N'2022-04-29 14:48:34.040' AS DateTime), 1, CAST(N'2022-04-29 14:48:34.040' AS DateTime), 1, NULL, 1)
INSERT [dbo].[BlogCategory] ([blog_category_id], [guid], [category_name], [category_type], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (10, N'3c13b883-fdb7-4d06-ad0c-c3eb57e32cc4', N'Cosmetic', N'ic', CAST(N'2022-04-29 14:49:06.747' AS DateTime), 1, CAST(N'2022-04-29 14:49:06.747' AS DateTime), 1, NULL, 1)
INSERT [dbo].[BlogCategory] ([blog_category_id], [guid], [category_name], [category_type], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (11, N'9ac29312-5d49-4476-b36a-1b21f2a8f177', N'Bags', N'ic', CAST(N'2022-04-29 14:50:56.657' AS DateTime), 1, CAST(N'2022-04-29 14:50:56.657' AS DateTime), 1, NULL, 1)
INSERT [dbo].[BlogCategory] ([blog_category_id], [guid], [category_name], [category_type], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (12, N'bcf7308c-9625-4832-b16f-bc2afee4010b', N'Footwear', N'ic', CAST(N'2022-04-29 14:51:45.390' AS DateTime), 1, CAST(N'2022-04-29 14:51:45.390' AS DateTime), 1, NULL, 1)
INSERT [dbo].[BlogCategory] ([blog_category_id], [guid], [category_name], [category_type], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (13, N'b623b342-03dd-43a7-bdc0-a2dad55bb615', N'Glasses', N'ic', CAST(N'2022-04-29 14:52:49.300' AS DateTime), 1, CAST(N'2022-04-29 14:52:49.300' AS DateTime), 1, NULL, 1)
SET IDENTITY_INSERT [dbo].[BlogCategory] OFF
SET IDENTITY_INSERT [dbo].[BlogMaster] ON 

INSERT [dbo].[BlogMaster] ([blog_master_id], [guid], [blog_category_id], [category_name], [blog_title], [blog_friendly_url], [blog_description], [blog_outer_image], [blog_thumbnail], [blog_inner_banner_img], [author_name], [blog_view], [is_published], [published_on], [is_featured], [blog_tag_id], [tag_name], [page_title], [meta_Key], [meta_description], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (1, N'd72b7ecd-5bd4-47c2-a31a-3e594ddea4ec', 1, N'Parental', N'I am a Work-In-Progress, not a Problem to be solved', N'I-am-a-Work-In-Progress-not-a-Problem-to-be-solved', N'<p>It&rsquo;s hard to learn this but it&rsquo;s not impossible. From many years, I was a person who used to take everything personally. I couldn&rsquo;t let go of things and people. If something bothered me, it used to get stuck on me. And when I developed PTSD, situation became worse. Everything bothered me, stressed me.Even very small things.</p>

<p>But now I won the battle. Now nothing stress me as I have learned to let go&nbsp;&nbsp;of things which I can&rsquo;t control. I know I can&rsquo;t control the actions of<br />
others, I can only control what I do with myself afterward.</p>

<p>It&rsquo;s hard to learn this but it&rsquo;s not impossible. From many years, I was a person who used to take everything personally. I couldn&rsquo;t let go of things and people. If something bothered me, it used to get stuck on me. And when I developed PTSD, situation became worse. Everything bothered me, stressed me.Even very small things.</p>

<p>But now I won the battle. Now nothing stress me as I have learned to let go&nbsp;&nbsp;of things which I can&rsquo;t control. I know I can&rsquo;t control the actions of<br />
others, I can only control what I do with myself afterward.</p>
', N'f290db2c-2c49-409a-a41d-71fabd343f3d_blog.png', NULL, NULL, N'Deepak Saini', 120, 1, CAST(N'2022-04-26 17:21:58.700' AS DateTime), 1, N'4,5,6', N'Tag One,Tag Two,Tag Three', N'Software Development Company in Rohtak | Softcron', N'best Software development company in Rohtak, best Software development services in Rohtak, top Software development services in Rohtak , Software development company in Rohtak , software development company in Rohtak, best Software development company in Rohtak, Software application development company in Rohtak.', N'Softcron Technologies is providing top Software development solutions and the best software development services into every business domain. We are the best Software development solution provider company dealing in all enterprise solutions.', CAST(N'2022-04-18 13:30:45.287' AS DateTime), 1, CAST(N'2022-04-26 17:21:58.700' AS DateTime), 1, N'172.16.80.1', 1)
INSERT [dbo].[BlogMaster] ([blog_master_id], [guid], [blog_category_id], [category_name], [blog_title], [blog_friendly_url], [blog_description], [blog_outer_image], [blog_thumbnail], [blog_inner_banner_img], [author_name], [blog_view], [is_published], [published_on], [is_featured], [blog_tag_id], [tag_name], [page_title], [meta_Key], [meta_description], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (2, N'f06650b6-d79c-4327-b03f-bb5efcaafa41', 3, N'Child Care', N'This is Child care Sample Title', N'This-is-Child-care-Sample-Title', N'<p>It&rsquo;s hard to learn this but it&rsquo;s not impossible. From many years, I was a person who used to take everything personally. I couldn&rsquo;t let go of things and people. If something bothered me, it used to get stuck on me. And when I developed PTSD, situation became worse. Everything bothered me, stressed me.Even very small things.</p>

<p>But now I won the battle. Now nothing stress me as I have learned to let go&nbsp;&nbsp;of things which I can&rsquo;t control. I know I can&rsquo;t control the actions of<br />
others, I can only control what I do with myself afterward.</p>

<p>It&rsquo;s hard to learn this but it&rsquo;s not impossible. From many years, I was a person who used to take everything personally. I couldn&rsquo;t let go of things and people. If something bothered me, it used to get stuck on me. And when I developed PTSD, situation became worse. Everything bothered me, stressed me.Even very small things.</p>

<p>But now I won the battle. Now nothing stress me as I have learned to let go&nbsp;&nbsp;of things which I can&rsquo;t control. I know I can&rsquo;t control the actions of<br />
others, I can only control what I do with myself afterward.</p>
', N'b47e8766-6fb9-47a2-88fa-677cafa66fd2_blog.png', NULL, NULL, N'Deepak Saini', 100, 0, NULL, 1, N'4,6', N'Tag One,Tag Three', N'Software Development Company in Rohtak | Softcron', N'best Software development company in Rohtak, best Software development services in Rohtak, top Software development services in Rohtak , Software development company in Rohtak , software development company in Rohtak, best Software development company in Rohtak, Software application development company in Rohtak.', N'Softcron Technologies is providing top Software development solutions and the best software development services into every business domain. We are the best Software development solution provider company dealing in all enterprise solutions.', CAST(N'2022-04-18 13:41:50.017' AS DateTime), 1, CAST(N'2022-04-20 17:48:24.293' AS DateTime), 1, N'172.16.80.1', 1)
INSERT [dbo].[BlogMaster] ([blog_master_id], [guid], [blog_category_id], [category_name], [blog_title], [blog_friendly_url], [blog_description], [blog_outer_image], [blog_thumbnail], [blog_inner_banner_img], [author_name], [blog_view], [is_published], [published_on], [is_featured], [blog_tag_id], [tag_name], [page_title], [meta_Key], [meta_description], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (3, N'd48b7c5e-20d3-4ffb-92d9-0fada3dda7b4', 3, N'Child Care', N'This is Child Care 2', N'This-is-Child-care', N'<p>It&rsquo;s hard to learn this but it&rsquo;s not impossible. From many years, I was a person who used to take everything personally. I couldn&rsquo;t let go of things and people. If something bothered me, it used to get stuck on me. And when I developed PTSD, situation became worse. Everything bothered me, stressed me.Even very small things.</p>

<p>But now I won the battle. Now nothing stress me as I have learned to let go&nbsp;&nbsp;of things which I can&rsquo;t control. I know I can&rsquo;t control the actions of<br />
others, I can only control what I do with myself afterward.</p>

<p>It&rsquo;s hard to learn this but it&rsquo;s not impossible. From many years, I was a person who used to take everything personally. I couldn&rsquo;t let go of things and people. If something bothered me, it used to get stuck on me. And when I developed PTSD, situation became worse. Everything bothered me, stressed me.Even very small things.</p>

<p>But now I won the battle. Now nothing stress me as I have learned to let go&nbsp;&nbsp;of things which I can&rsquo;t control. I know I can&rsquo;t control the actions of<br />
others, I can only control what I do with myself afterward.</p>
', N'3d7aa4c2-1290-4289-8395-e40df82ebb2a_blog.png', NULL, NULL, N'Deepak Saini', 1000, 0, CAST(N'2022-04-26 10:41:50.223' AS DateTime), 1, N'5,6', N'Tag Two,Tag Three', N'Software Development Company in Rohtak | Softcron', N'best Software development company in Rohtak, best Software development services in Rohtak, top Software development services in Rohtak , Software development company in Rohtak , software development company in Rohtak, best Software development company in Rohtak, Software application development company in Rohtak.', N'Softcron Technologies is providing top Software development solutions and the best software development services into every business domain. We are the best Software development solution provider company dealing in all enterprise solutions.', CAST(N'2022-04-25 11:35:05.057' AS DateTime), 1, CAST(N'2022-04-29 10:13:28.827' AS DateTime), 1, N'103.108.220.238', 1)
INSERT [dbo].[BlogMaster] ([blog_master_id], [guid], [blog_category_id], [category_name], [blog_title], [blog_friendly_url], [blog_description], [blog_outer_image], [blog_thumbnail], [blog_inner_banner_img], [author_name], [blog_view], [is_published], [published_on], [is_featured], [blog_tag_id], [tag_name], [page_title], [meta_Key], [meta_description], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (4, N'c6c2b748-d80a-4802-b756-fbef94cf9ccf', 8, N'Spiritual', N'This is my new blog to check out few things', N'This-is-my-new-blog-to-check-out-few-things', N'<p>&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;this aosf asogasd asdoih asdogas dovasov&nbsp;</p>
', N'3a3a8342-fa96-46ad-99e5-0ed352acfc0a_blog.png', NULL, NULL, N'Joginder M', 8181, 1, CAST(N'2022-04-27 20:38:14.413' AS DateTime), 1, N'4,5', N'Tag One,Tag Two', N'Software Development Company in Rohtak | Softcron', N'best Software development company in Rohtak, best Software development services in Rohtak, top Software development services in Rohtak , Software development company in Rohtak , software development company in Rohtak, best Software development company in Rohtak, Software application development company in Rohtak.', N'Softcron Technologies is providing top Software development solutions and the best software development services into every business domain. We are the best Software development solution provider company dealing in all enterprise solutions.', CAST(N'2022-04-27 20:37:26.930' AS DateTime), 1, CAST(N'2022-04-30 12:44:37.170' AS DateTime), 1, N'103.108.220.238', 0)
INSERT [dbo].[BlogMaster] ([blog_master_id], [guid], [blog_category_id], [category_name], [blog_title], [blog_friendly_url], [blog_description], [blog_outer_image], [blog_thumbnail], [blog_inner_banner_img], [author_name], [blog_view], [is_published], [published_on], [is_featured], [blog_tag_id], [tag_name], [page_title], [meta_Key], [meta_description], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (5, N'fe8775dc-5951-4322-8a24-673f156b459a', 2, N'Home Decors', N'This is Home Decors Sample Blog', N'This-is-Home-Decors-Sample-Blog', N'<p><strong><span style="font-size:14px"><span style="color:#e74c3c">Home Decors Blog</span></span></strong></p>

<p><span style="font-size:12px">This is Home Decor Blog it is a very Useful Effective and Good Blog nowadays.&nbsp;This is Home Decor Blog it is a very Useful Effective and Good Blog nowadays.</span></p>

<p><span style="font-size:12px">This is Home Decor Blog it is a very Useful Effective and Good Blog nowadays.&nbsp;This is Home Decor Blog it is a very Useful Effective and Good Blog nowadays.</span></p>

<p><span style="font-size:12px">This is Home Decor Blog it is a very Useful Effective and Good Blog nowadays.&nbsp;This is Home Decor Blog it is a very Useful Effective and Good Blog nowadays.</span></p>

<p><span style="font-size:12px">This is Home Decor Blog it is a very Useful Effective and Good Blog nowadays.&nbsp;This is Home Decor Blog it is a very Useful Effective and Good Blog nowadays.</span></p>

<p><span style="font-size:12px">This is Home Decor Blog it is a very Useful Effective and Good Blog nowadays.&nbsp;This is Home Decor Blog it is a very Useful Effective and Good Blog nowadays.</span></p>
', N'blogouter_1360192920.jpg', N'blogthumbnail_62386690.jpg', N'bloginner_654296892.jpg', N'Deepak Saini', 1000, 0, CAST(N'2022-05-06 10:42:14.000' AS DateTime), 1, N'5,7', N'Tag Two,Tag Four', N'Software Development Company in Rohtak | Softcron', N'best Software development company in Rohtak, best Software development services in Rohtak, top Software development services in Rohtak , Software development company in Rohtak , software development company in Rohtak, best Software development company in Rohtak, Software application development company in Rohtak.', N'Softcron Technologies is providing top Software development solutions and the best software development services into every business domain. We are the best Software development solution provider company dealing in all enterprise solutions.', CAST(N'2022-05-06 11:42:06.123' AS DateTime), 1, CAST(N'2022-05-06 11:42:06.123' AS DateTime), 1, NULL, 1)
SET IDENTITY_INSERT [dbo].[BlogMaster] OFF
SET IDENTITY_INSERT [dbo].[CommentMaster] ON 

INSERT [dbo].[CommentMaster] ([comment_master_id], [guid], [blog_master_id], [comment_by_user_name], [user_image], [blog_comment], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (1, N'e23ee618-7fd3-4f1e-9ca2-c4922582f1e9', 1, N'guest', NULL, N'this is the test comment that i want to say that we are doig a agood thing ehre and lets plan somehting new to do this blog and lets publicusew the same
', CAST(N'2022-05-04 11:53:39.090' AS DateTime), 0, CAST(N'2022-05-04 11:53:39.090' AS DateTime), 0, NULL, 1)
SET IDENTITY_INSERT [dbo].[CommentMaster] OFF
SET IDENTITY_INSERT [dbo].[ContactMaster] ON 

INSERT [dbo].[ContactMaster] ([contact_master_id], [guid], [full_name], [email], [phone_number], [subject], [message], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (1, N'9d8d4393-ebe9-4a0a-8b41-849f102d31e4', N'Deepak Saini', N'shinescare@gmail.com', N'7206769157', N'This is Sample Test Data', N'This is Sample Test Data . i need help', CAST(N'2022-04-14 18:00:44.397' AS DateTime), 0, CAST(N'2022-04-14 18:00:44.397' AS DateTime), 0, N'172.16.80.1', 1)
INSERT [dbo].[ContactMaster] ([contact_master_id], [guid], [full_name], [email], [phone_number], [subject], [message], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (2, N'2fa5ce65-d765-43f1-97db-0cc1de0cfee0', N'Deepak', N'deepaksaini307@gmail.com', N'7206769157', N'Testing', N'This is for Testing Purpose', CAST(N'2022-04-14 18:44:57.897' AS DateTime), 0, CAST(N'2022-04-14 18:44:57.897' AS DateTime), 0, N'172.16.80.1', 1)
INSERT [dbo].[ContactMaster] ([contact_master_id], [guid], [full_name], [email], [phone_number], [subject], [message], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (3, N'c49f6309-4cf4-4028-92dd-b4ecfb3f753f', N'Karan', N'karankatyal1998@gmail.com', N'9996222567', N'Dummy Subject', N'Testing', CAST(N'2022-04-15 11:07:42.860' AS DateTime), 0, CAST(N'2022-04-15 11:07:42.860' AS DateTime), 0, N'172.16.80.1', 1)
INSERT [dbo].[ContactMaster] ([contact_master_id], [guid], [full_name], [email], [phone_number], [subject], [message], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (4, N'bea19546-9ade-4393-8a01-88d696a186a2', N'Karan', N'karankatyal1998@gmail.com', N'9996222567', N'Dummy Subject', N'Test', CAST(N'2022-04-18 11:13:28.587' AS DateTime), 0, CAST(N'2022-04-18 11:13:28.587' AS DateTime), 0, N'172.16.80.1', 1)
INSERT [dbo].[ContactMaster] ([contact_master_id], [guid], [full_name], [email], [phone_number], [subject], [message], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (5, N'2df4ab5c-8bd3-4cc4-980b-9ababa917f83', N'Deepak', N'deepaksaini307@gmail.com', N'7206769157', N'Dummy Subject', N'Testing', CAST(N'2022-04-18 12:18:29.743' AS DateTime), 0, CAST(N'2022-04-18 12:18:29.743' AS DateTime), 0, N'172.16.80.1', 1)
INSERT [dbo].[ContactMaster] ([contact_master_id], [guid], [full_name], [email], [phone_number], [subject], [message], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (6, N'd59b1f95-bacc-4378-b34f-cacfdf8929df', N'Deepak', N'deepaksaini307@gmail.com', N'7206769157', N'Testing', N'Testing', CAST(N'2022-04-19 11:27:31.277' AS DateTime), 0, CAST(N'2022-04-19 11:27:31.277' AS DateTime), 0, N'172.16.80.1', 1)
INSERT [dbo].[ContactMaster] ([contact_master_id], [guid], [full_name], [email], [phone_number], [subject], [message], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (7, N'5d46df77-4333-4bda-b7e3-c60470342f4b', N'Joginder', N'shiencare@gmail.com', N'8199818181', N'Please help me', N'hi this is joginder and io want to get moticated to see the things taht yupoa re alreayd doing', CAST(N'2022-04-27 20:24:42.613' AS DateTime), 0, CAST(N'2022-04-27 20:24:42.613' AS DateTime), 0, N'202.9.120.142', 1)
SET IDENTITY_INSERT [dbo].[ContactMaster] OFF
SET IDENTITY_INSERT [dbo].[GalleryMaster] ON 

INSERT [dbo].[GalleryMaster] ([gallery_master_id], [guid], [name], [gallery_type], [image], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (1, N'e4437fde-85cc-41a4-8000-5a6c42fc8864', N'Meeting 2021', NULL, N'gallery_311400596.png', CAST(N'2022-04-25 12:17:03.020' AS DateTime), 1, CAST(N'2022-04-25 12:17:03.020' AS DateTime), 1, NULL, 1)
INSERT [dbo].[GalleryMaster] ([gallery_master_id], [guid], [name], [gallery_type], [image], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (2, N'b5b0c898-e41d-4c66-bb74-3c5a76a49e83', N'Gallery 1', NULL, N'gallery_927223241.png', CAST(N'2022-04-26 16:54:21.890' AS DateTime), 1, CAST(N'2022-04-26 16:54:21.890' AS DateTime), 1, NULL, 1)
INSERT [dbo].[GalleryMaster] ([gallery_master_id], [guid], [name], [gallery_type], [image], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (3, N'b43c7229-3362-43ea-916f-c315e7f52dfa', N'Gallery 2', NULL, N'gallery_1526206193.png', CAST(N'2022-04-26 17:23:16.900' AS DateTime), 1, CAST(N'2022-04-26 17:23:16.900' AS DateTime), 1, NULL, 1)
INSERT [dbo].[GalleryMaster] ([gallery_master_id], [guid], [name], [gallery_type], [image], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (4, N'fc139815-c9c8-4c40-83a8-71d946568ca7', N'Testing ', NULL, N'gallery_576819709.jpg', CAST(N'2022-04-27 20:44:05.683' AS DateTime), 1, CAST(N'2022-04-27 20:44:05.683' AS DateTime), 1, NULL, 0)
INSERT [dbo].[GalleryMaster] ([gallery_master_id], [guid], [name], [gallery_type], [image], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (5, N'7a1223b4-cefb-46c4-8575-c6b0054e8554', N'Gallery 3', NULL, N'gallery_1980659605.png', CAST(N'2022-04-28 16:52:19.313' AS DateTime), 1, CAST(N'2022-04-28 16:52:19.313' AS DateTime), 1, NULL, 1)
INSERT [dbo].[GalleryMaster] ([gallery_master_id], [guid], [name], [gallery_type], [image], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (6, N'e2f4a874-91ff-4add-a3be-449bedac7947', N'Gallery 4', NULL, N'gallery_591493719.png', CAST(N'2022-04-28 17:18:45.280' AS DateTime), 1, CAST(N'2022-04-28 17:18:45.280' AS DateTime), 1, NULL, 1)
INSERT [dbo].[GalleryMaster] ([gallery_master_id], [guid], [name], [gallery_type], [image], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (7, N'39a0f3b2-b4e4-4cd9-833e-c4e00d86f8b6', N'Gallery 5', NULL, N'gallery_81787108.png', CAST(N'2022-04-28 17:19:13.767' AS DateTime), 1, CAST(N'2022-04-28 17:19:13.767' AS DateTime), 1, NULL, 1)
INSERT [dbo].[GalleryMaster] ([gallery_master_id], [guid], [name], [gallery_type], [image], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (8, N'e95de96b-fde8-48bc-a8c5-10223a351615', N'Gallery 6', NULL, N'gallery_1631295226.png', CAST(N'2022-04-28 18:13:27.847' AS DateTime), 1, CAST(N'2022-04-28 18:13:27.847' AS DateTime), 1, NULL, 1)
INSERT [dbo].[GalleryMaster] ([gallery_master_id], [guid], [name], [gallery_type], [image], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (9, N'0dc88e7f-d251-46dc-8bb4-388b43e9642c', N'Gallery 7', NULL, N'gallery_1359070202.png', CAST(N'2022-04-28 18:14:23.727' AS DateTime), 1, CAST(N'2022-04-28 18:14:23.727' AS DateTime), 1, NULL, 1)
SET IDENTITY_INSERT [dbo].[GalleryMaster] OFF
SET IDENTITY_INSERT [dbo].[HomeContentMaster] ON 

INSERT [dbo].[HomeContentMaster] ([home_content_master_id], [guid], [content_page], [content_type], [content_title], [content_description], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (1, N'2253337f-418b-4971-9830-b8a8367e1c9a', N'home', N'footeraboutus', N'', N'<p>Healing 2 Peace is the journey of different brave souls from suffering to surviving their pain. It is not just mine or my kids journey, anyone can join us. It doesn&rsquo;t matter what they survived, it only matters that they did.</p>
', CAST(N'2022-04-25 12:24:17.890' AS DateTime), 1, CAST(N'2022-04-25 12:24:17.890' AS DateTime), 1, NULL, 1)
INSERT [dbo].[HomeContentMaster] ([home_content_master_id], [guid], [content_page], [content_type], [content_title], [content_description], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (2, N'8708062f-0090-45a3-935d-2b00b5bb155e', N'home', N'footersubscribe', N'', N'<p>Get designer inspiration, first looks &amp; more</p>
', CAST(N'2022-04-25 12:25:37.783' AS DateTime), 1, CAST(N'2022-04-25 12:25:37.783' AS DateTime), 1, NULL, 1)
INSERT [dbo].[HomeContentMaster] ([home_content_master_id], [guid], [content_page], [content_type], [content_title], [content_description], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (3, N'd67aeeab-4762-4b8d-8f91-30d74b690d73', N'home', N'ourvision', N'', N'<p style="text-align:center">Sharing stories of victories and defeats with others is important to heal. The healing that happens when you&#39;ve heard and validated is remarkable.</p>

<p style="text-align:center">Healing 2 Peace is the journey of different brave souls from suffering to surviving their pain. It is not just mine or my kids&#39; journey, anyone can join us. It doesn&rsquo;t matter what they survived, it only matters that they did.</p>

<p style="text-align:center">Our mission is to promote self-reliance and empowerment. We educate and empower others about the abuse we suffered, how we survived and what resources we found helpful for us to overcome our suffering.</p>
', CAST(N'2022-04-25 18:29:13.973' AS DateTime), 1, CAST(N'2022-04-25 18:29:13.973' AS DateTime), 1, NULL, 1)
INSERT [dbo].[HomeContentMaster] ([home_content_master_id], [guid], [content_page], [content_type], [content_title], [content_description], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (4, N'd82c79e0-9e76-48e7-aa6a-69859369d148', N'home', N'meetme', N'', N'<p style="text-align:center">A Blogger test, an Interior Stylist, and an Architect by profession, but I also did my Bachelor&rsquo;s degree in Computer Application and Psychology.</p>

<p style="text-align:center">When I was in India, I created my own Home D&eacute;cor brand with an e-commerce business. Also, I worked as a blogger with my niche as interior design, fashion, lifestyle, and parenting. So that&rsquo;s another feather in my small crown.</p>

<p style="text-align:center">I came to the United States in 2019 with my husband and my 2 kids. My husband was abusive since the first day of our relationship, before and after we married.</p>
', CAST(N'2022-04-25 18:30:40.477' AS DateTime), 1, CAST(N'2022-04-25 18:30:40.477' AS DateTime), 1, NULL, 1)
INSERT [dbo].[HomeContentMaster] ([home_content_master_id], [guid], [content_page], [content_type], [content_title], [content_description], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (5, N'96f3229d-4bd3-4574-a882-4bdc8a2c1480', N'meetme', N'meetme', N'<p style="text-align:center">&ldquo; I&rsquo;m thankful for my struggles because, without them, I wouldn&rsquo;t know my strengths.&rdquo;&nbsp;<br />
I believe in setting an example instead of just giving any advicee.</p>
', N'<p style="text-align:center">A Bloggerr, an Interior Stylist, and an Architect by profession, but I also did my Bachelor&rsquo;s degree in Computer Application and Psychology. When I was in India, I created my own Home D&eacute;cor brand with an e-commerce business. Also, I worked as a blogger with my niche as interior design, fashion, lifestyle, and parenting. So that&rsquo;s another feather in my small crown.</p>

<p style="text-align:center">I came to the United States in 2019 with my husband and my 2 kids. My husband was abusive since the first day of our relationship, before and after we married. We were together for 13 years, out of which 11 years of our marriage involved every kind of abuse (verbal, emotional, physical, sexual, financial, and psychological). Trauma not only comes in memories, it can come back in physical symptoms too. As a result of the violence and abuse I suffered, I have to see so many doctors, therapists, and specialists every other day. It looks like I&rsquo;m physically out of it but somewhere I&rsquo;m still stuck there.</p>

<p style="text-align:center">With this website and my blogs, I&rsquo;ll tell you how I survived my pain and suffering along with my kids handling my abuser and my business. Maybe my words reach someone who can relate and find some help. I am aware I can&rsquo;t save the world but at least I can try to make some difference. This website is an initiative to help me and others in healing. I am sharing my experiences and journey as a Victim/Survivor but I prefer calling myself a normal woman just like you. Maybe I&rsquo;ll be able to save just ONE life besides my own.</p>

<p style="text-align:center">So, you are at the right place if you&rsquo;re looking for ways to cope with your pain and heal from any kind of trauma. This journey of mine is now our journey, and I cannot thankyou enough for joining it with me.</p>
', CAST(N'2022-04-25 18:33:36.620' AS DateTime), 1, CAST(N'2022-04-25 18:33:36.620' AS DateTime), 1, NULL, 1)
INSERT [dbo].[HomeContentMaster] ([home_content_master_id], [guid], [content_page], [content_type], [content_title], [content_description], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (6, N'87e1e385-2f8a-441c-9acd-66e58a06081d', N'ourvision', N'ourvision', N'<p style="text-align:center">&ldquo;Yesterday is not ours to recover, but tomorrow is ours to win or lose.<br />
I think that power is the principle. So let&rsquo;s get powerful by getting our power back.&rdquo; &ndash; ANJU K</p>
', N'<p style="text-align:center">Sharing stories of victories and defeats with others is important to heal. The healing that happens when you&#39;ve heard and validated is remarkable.</p>

<p style="text-align:center">Healing 2 Peace is the journey of different brave souls from suffering to surviving their pain. It is not just mine or my kids&#39; journey, anyone can join us. It doesn&rsquo;t matter what they survived, it only matters that they did.</p>

<p style="text-align:center">Our mission is to promote self-reliance and empowerment. We educate and empower others about the abuse we suffered, how we survived and what resources we found helpful for us to overcome our suffering.</p>

<p style="text-align:center">Our aim is to provide a platform for victims/survivors, to tell them about available resources and other coping skills. We will tailor this platform to meet the special needs of other brave souls who are overcoming hardship.</p>

<p style="text-align:center">After devastating events, getting back to normal is hard. For some of us, financial insecurity becomes a major obstacle. Yes, there are many resources available to help us but when we are in the healing process, it is overwhelming to ask for help. It feels like we are</p>

<p style="text-align:center">asking for too much. So when we are in therapy, using our pain, creativity, and skills, we create awesome and amazing things.</p>

<p style="text-align:center">Join us, maybe you will also find your passion.</p>

<p style="text-align:center">It is a wrenching feeling going from being self-sufficient to needing money (from others) for every little thing.</p>

<p style="text-align:center">If you want to speak, write or create-this is a safe place for that.</p>

<p style="text-align:center">We also want to hear from counselors &ndash; you are doing this job for a reason and you may want to express it to us.</p>
', CAST(N'2022-04-25 18:37:10.533' AS DateTime), 1, CAST(N'2022-04-25 18:37:10.533' AS DateTime), 1, NULL, 1)
SET IDENTITY_INSERT [dbo].[HomeContentMaster] OFF
SET IDENTITY_INSERT [dbo].[ItemMaster] ON 

INSERT [dbo].[ItemMaster] ([item_master_id], [guid], [item_category_id], [category_name], [item_name], [item_title], [item_description], [item_image], [item_old_price], [item_new_price], [is_discount], [item_discount_in_percentage], [item_discount_in_amount], [item_stock], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (1, N'52a83b84-93d0-4ead-a003-583d500588eb', 9, N'Clothes', N'T-Shirt', N'Men Fancy T-Shirt all over the nation', N'<p>Keeping in mind the precise demands of clients, we offer a designer collection of<strong>&nbsp;Men&#39;s Fancy T-Shirts</strong>&nbsp;all over the nation.<br />
These are exclusively designed using top-quality fabrics which are sourced from reliable vendors in the industry. Our range is very comfortable to wear and its proper fitting makes it highly demanded by our clients.</p>
', N'test.jpg', CAST(200.00 AS Decimal(18, 2)), CAST(250.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(50.00 AS Decimal(18, 2)), 50, CAST(N'2022-04-29 12:50:46.120' AS DateTime), 1, CAST(N'2022-04-29 12:50:46.120' AS DateTime), 1, NULL, 1)
INSERT [dbo].[ItemMaster] ([item_master_id], [guid], [item_category_id], [category_name], [item_name], [item_title], [item_description], [item_image], [item_old_price], [item_new_price], [is_discount], [item_discount_in_percentage], [item_discount_in_amount], [item_stock], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (2, N'be41f4d5-166b-4157-931a-ad92524dc94e', 13, N'Glasses', N'Sun Glass', N'This frame holds the lens in front of the eyes while a bridge goes over the ears', N'<p>Keeping in mind the precise demands of clients, we offer a designer collection of<strong>&nbsp;Men&#39;s Fancy T-Shirts</strong>&nbsp;all over the nation.<br />
These are exclusively designed using top-quality fabrics which are sourced from reliable vendors in the industry. Our range is very comfortable to wear and its proper fitting makes it highly demanded by our clients.</p>
', N'item_1121325310.jpg', CAST(500.00 AS Decimal(18, 2)), CAST(500.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), 25, CAST(N'2022-04-29 15:53:13.117' AS DateTime), 1, CAST(N'2022-04-29 15:53:13.117' AS DateTime), 1, NULL, 1)
INSERT [dbo].[ItemMaster] ([item_master_id], [guid], [item_category_id], [category_name], [item_name], [item_title], [item_description], [item_image], [item_old_price], [item_new_price], [is_discount], [item_discount_in_percentage], [item_discount_in_amount], [item_stock], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (3, N'19c8dcf4-853d-4615-a633-4321a5159811', 13, N'Glasses', N'Normal Glass', N'This frame holds the lens in front of the eyes while a bridge goes over the ears', N'<ul>
	<li>This frame holds the lens in front of the eyes while a bridge goes over the ears</li>
	<li>This frame holds the lens in front of the eyes while a bridge goes over the ears</li>
	<li>This frame holds the lens in front of the eyes while a bridge goes over the ears</li>
	<li>This frame holds the lens in front of the eyes while a bridge goes over the ears</li>
</ul>
', N'item_96560449.jpg', CAST(250.00 AS Decimal(18, 2)), CAST(250.00 AS Decimal(18, 2)), 1, CAST(10.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 50, CAST(N'2022-04-29 15:56:07.180' AS DateTime), 1, CAST(N'2022-04-29 15:56:07.180' AS DateTime), 1, NULL, 1)
SET IDENTITY_INSERT [dbo].[ItemMaster] OFF
SET IDENTITY_INSERT [dbo].[MenuMaster] ON 

INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (1, N'ef373c2f-479b-4631-a648-52975a84e87a', N'Home', N'#', 0, 1, 0, N'gi gi-home sidebar-nav-icon', CAST(N'2022-04-26 13:46:00.573' AS DateTime), 1, CAST(N'2022-04-26 13:46:00.573' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (2, N'809c0a0d-7c8f-4d56-bff7-8fc17d89253c', N'Role Master', N'#', 0, 2, 0, N'gi gi-user sidebar-nav-icon', CAST(N'2022-04-26 13:46:59.090' AS DateTime), 1, CAST(N'2022-04-26 13:46:59.090' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (3, N'9c15d244-2339-4fd2-9a79-a5f23014aa1e', N'User Master', N'#', 0, 3, 0, N'gi gi-user sidebar-nav-icon', CAST(N'2022-04-26 13:47:47.873' AS DateTime), 1, CAST(N'2022-04-26 13:47:47.873' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (4, N'c4fe5b13-0d79-45e7-97b0-153570ec3439', N'Feature Master', N'#', 0, 4, 0, N'fa fa-th sidebar-nav-icon', CAST(N'2022-04-26 13:48:47.327' AS DateTime), 1, CAST(N'2022-04-26 13:48:47.327' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (5, N'4d4f005a-1c77-4488-83d2-fee22a37b40c', N'Blog Master', N'#', 0, 5, 0, N'fa fa-th sidebar-nav-icon', CAST(N'2022-04-26 13:55:12.040' AS DateTime), 1, CAST(N'2022-04-26 13:55:12.040' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (6, N'745b98fd-00b7-45cd-8647-90eed87c22a3', N'Testimonial Master', N'#', 0, 6, 0, N'fa fa-quote-left', CAST(N'2022-04-26 13:55:38.790' AS DateTime), 1, CAST(N'2022-04-26 13:55:38.790' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (7, N'2b75e217-5943-48a6-bf4a-ae770664a085', N'Subscribe Master', N'#', 0, 8, 0, N'gi gi-user sidebar-nav-icon', CAST(N'2022-04-26 13:56:15.700' AS DateTime), 1, CAST(N'2022-04-26 13:56:15.700' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (8, N'6dcb7ef3-cd33-4bea-8395-7deeb1b96957', N'Contact Master', N'#', 0, 9, 0, N'gi gi-certificate sidebar-nav-icon', CAST(N'2022-04-26 13:56:55.700' AS DateTime), 1, CAST(N'2022-04-26 13:56:55.700' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (9, N'ca8fe456-ae2b-497d-a1a5-b422a9955414', N'Manage User', N'/manage-user', 3, 0, 1, N'', CAST(N'2022-04-26 13:58:07.123' AS DateTime), 1, CAST(N'2022-04-26 13:58:07.123' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (10, N'94af2f95-bea4-45cc-8278-b74ecd2f6a2f', N'Manage Role', N'/manage-role', 2, 0, 1, N'', CAST(N'2022-04-26 13:58:53.767' AS DateTime), 1, CAST(N'2022-04-26 13:58:53.767' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (11, N'27995e5a-6ec9-457f-8d35-ace0b493ba22', N'Manage Social Links', N'/manage-social-links', 4, 0, 1, N'', CAST(N'2022-04-26 13:59:39.347' AS DateTime), 1, CAST(N'2022-04-26 13:59:39.347' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (12, N'ce39bd9a-cc9c-4efa-8a7f-3c3ff3d7ab46', N'Manage Gallery', N'/manage-gallery', 4, 0, 2, N'', CAST(N'2022-04-26 14:00:10.410' AS DateTime), 1, CAST(N'2022-04-26 14:00:10.410' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (13, N'374ceadf-4c16-408a-a0a4-466f88b35f9d', N'Site Content Manager', N'/site-content-master', 4, 0, 3, N'', CAST(N'2022-04-26 14:00:42.207' AS DateTime), 1, CAST(N'2022-04-26 14:00:42.207' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (14, N'aacc6de2-cfb5-47f3-83c5-1a8a70fc26f9', N'Manage Blog Category', N'/manage-blog-category', 5, 0, 1, N'', CAST(N'2022-04-26 14:01:28.193' AS DateTime), 1, CAST(N'2022-04-26 14:01:28.193' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (15, N'652d58d1-7f2c-4d38-a00a-588341994688', N'Manage Blog ', N'/manage-blog', 5, 0, 2, N'', CAST(N'2022-04-26 14:02:04.570' AS DateTime), 1, CAST(N'2022-04-26 14:02:04.570' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (16, N'f8cdd274-6e32-42d3-8ef7-ed50fc314308', N'Manage Testimonials', N'/manage-testimonial', 6, 0, 1, N'', CAST(N'2022-04-26 14:52:11.650' AS DateTime), 1, CAST(N'2022-04-26 14:52:11.650' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (17, N'b2981818-0279-405c-94d7-c432147aa946', N'Subscriber List', N'/manage-subscribe', 7, 0, 1, N'', CAST(N'2022-04-26 14:52:41.197' AS DateTime), 1, CAST(N'2022-04-26 14:52:41.197' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (18, N'4ffe8719-8c70-40ed-8bb0-f369fa237a2b', N'Contact List', N'/manage-contact', 8, 0, 1, N'', CAST(N'2022-04-26 14:53:06.307' AS DateTime), 1, CAST(N'2022-04-26 14:53:06.307' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (19, N'124db742-35f1-44f3-91f0-10f6745ce47f', N'Item Master', N'#', 0, 7, 0, N'fa fa-th sidebar-nav-icon', CAST(N'2022-04-29 17:56:37.837' AS DateTime), 1, CAST(N'2022-04-29 17:56:37.837' AS DateTime), 1, NULL, 1)
INSERT [dbo].[MenuMaster] ([menu_master_id], [guid], [display_name], [page_url], [parent_id], [parent_order], [child_order], [cssclass], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (20, N'28286d65-dc31-41cb-878f-b61ab152a421', N'Manage Items', N'/manage-item', 19, 0, 1, N'', CAST(N'2022-04-30 12:54:21.890' AS DateTime), 1, CAST(N'2022-04-30 12:54:21.890' AS DateTime), 1, NULL, 1)
SET IDENTITY_INSERT [dbo].[MenuMaster] OFF
SET IDENTITY_INSERT [dbo].[SocialMediaLinkMaster] ON 

INSERT [dbo].[SocialMediaLinkMaster] ([social_media_link_master_id], [guid], [link_name], [link_url], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (1, N'60f29958-b2e7-4eeb-aa29-96e8b78608e8', N'fab fa-facebook-f', N'https://www.facebook.com/profile.php?id=100072795660912', CAST(N'2022-04-25 18:00:16.737' AS DateTime), 1, CAST(N'2022-04-25 18:00:16.737' AS DateTime), 1, NULL, 1)
INSERT [dbo].[SocialMediaLinkMaster] ([social_media_link_master_id], [guid], [link_name], [link_url], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (2, N'df794fab-95c6-4690-b88d-84405d3c23eb', N'fab fa-instagram', N'https://instagram.com/anju29peace', CAST(N'2022-04-25 18:00:51.893' AS DateTime), 1, CAST(N'2022-04-25 18:00:51.893' AS DateTime), 1, NULL, 1)
INSERT [dbo].[SocialMediaLinkMaster] ([social_media_link_master_id], [guid], [link_name], [link_url], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (3, N'9a91ac13-21df-4b4b-a59c-af22dbbd0b99', N'fab fa-twitter', N'https://twitter.com/Anju29peace', CAST(N'2022-04-25 18:01:12.787' AS DateTime), 1, CAST(N'2022-04-25 18:01:12.787' AS DateTime), 1, NULL, 1)
INSERT [dbo].[SocialMediaLinkMaster] ([social_media_link_master_id], [guid], [link_name], [link_url], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (4, N'7b852220-a6fd-4ba0-8c7e-fb3a65c3bd4b', N'fab fa-youtube', N'https://youtube.com', CAST(N'2022-04-27 20:42:56.963' AS DateTime), 1, CAST(N'2022-04-27 20:42:56.963' AS DateTime), 1, NULL, 0)
SET IDENTITY_INSERT [dbo].[SocialMediaLinkMaster] OFF
SET IDENTITY_INSERT [dbo].[SubscribeMaster] ON 

INSERT [dbo].[SubscribeMaster] ([subscribe_master_id], [guid], [subscribe_email], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (1, N'4a323afa-86e0-4a82-805c-4614819b6532', N'deepaksaini307@gmail.com', CAST(N'2022-04-13 17:08:28.007' AS DateTime), 0, CAST(N'2022-04-13 17:08:28.007' AS DateTime), 0, N'172.16.80.1', 1)
INSERT [dbo].[SubscribeMaster] ([subscribe_master_id], [guid], [subscribe_email], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (2, N'daeede69-8641-485b-9eef-916a3ba2ea58', N'deepaksaini307@gmail.com', CAST(N'2022-04-15 11:26:39.833' AS DateTime), 0, CAST(N'2022-04-15 11:26:39.833' AS DateTime), 0, N'172.16.80.1', 1)
INSERT [dbo].[SubscribeMaster] ([subscribe_master_id], [guid], [subscribe_email], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (3, N'2eaf0b20-cd1a-490d-8418-14724218f037', N'karankatyal1998@gmail.com', CAST(N'2022-04-15 12:59:35.610' AS DateTime), 0, CAST(N'2022-04-15 12:59:35.610' AS DateTime), 0, N'172.16.80.1', 1)
INSERT [dbo].[SubscribeMaster] ([subscribe_master_id], [guid], [subscribe_email], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (4, N'5919e681-a111-4162-9690-bb2941df8c95', N'deepaksaini307@gmail.com', CAST(N'2022-04-18 13:45:55.293' AS DateTime), 0, CAST(N'2022-04-18 13:45:55.293' AS DateTime), 0, N'172.16.80.1', 1)
INSERT [dbo].[SubscribeMaster] ([subscribe_master_id], [guid], [subscribe_email], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (5, N'2795a989-6565-49f3-a2c6-6b9aafc8d036', N'jogi@gmail.com', CAST(N'2022-04-27 17:07:15.323' AS DateTime), 0, CAST(N'2022-04-27 17:07:15.323' AS DateTime), 0, N'103.206.103.199', 1)
INSERT [dbo].[SubscribeMaster] ([subscribe_master_id], [guid], [subscribe_email], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (6, N'fca3a544-fe11-4766-83c1-e25ce46837c5', N'joginder@test.com', CAST(N'2022-04-27 20:19:30.247' AS DateTime), 0, CAST(N'2022-04-27 20:19:30.247' AS DateTime), 0, N'202.9.120.142', 1)
SET IDENTITY_INSERT [dbo].[SubscribeMaster] OFF
SET IDENTITY_INSERT [dbo].[TestimonialMaster] ON 

INSERT [dbo].[TestimonialMaster] ([testimonial_master_id], [guid], [name], [testimonial_title], [testimonial_description], [image], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (1, N'9287052e-b5ab-46a3-a71d-e325c57a914d', N'Anju Kumari', N'What our clients are saying !', N'<p>Lorem Ipsum is simply dummy of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.</p>
', N'testimonial_1677942400.jpg', CAST(N'2022-04-25 11:44:43.423' AS DateTime), 1, CAST(N'2022-04-25 11:44:43.423' AS DateTime), 1, NULL, 1)
INSERT [dbo].[TestimonialMaster] ([testimonial_master_id], [guid], [name], [testimonial_title], [testimonial_description], [image], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (2, N'88309347-2596-4323-adf8-e106ac436ab6', N'John Doe', N'What our clients are saying !', N'<p>Lorem Ipsum is simply dummy of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.</p>
', N'testimonial_914053959.png', CAST(N'2022-04-25 17:35:18.700' AS DateTime), 1, CAST(N'2022-04-25 17:35:18.700' AS DateTime), 1, NULL, 1)
INSERT [dbo].[TestimonialMaster] ([testimonial_master_id], [guid], [name], [testimonial_title], [testimonial_description], [image], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (3, N'89e48d31-5fc3-4a29-8da2-28caf963d3bc', N'Joginder - CTO', N'Guys have done a great job', N'<p>this is the thing that I wanted to tell them that you guys are good going and make this done ASAP. this is a good and User friendly UI&nbsp;</p>
', N'testimonial_1492226687.jpg', CAST(N'2022-04-27 20:52:52.340' AS DateTime), 1, CAST(N'2022-04-27 20:52:52.340' AS DateTime), 1, NULL, 1)
SET IDENTITY_INSERT [dbo].[TestimonialMaster] OFF
SET IDENTITY_INSERT [dbo].[UserRole] ON 

INSERT [dbo].[UserRole] ([user_role_master_id], [guid], [user_role_name], [assigned_menu_ids], [assigned_feature_ids], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (1, N'b7458127-ecb3-4c2e-8ffa-11a7615f36d6', N'Admin', N'2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20', NULL, CAST(N'2022-04-14 17:03:24.500' AS DateTime), 1, CAST(N'2022-04-14 17:03:24.500' AS DateTime), 1, NULL, 1)
INSERT [dbo].[UserRole] ([user_role_master_id], [guid], [user_role_name], [assigned_menu_ids], [assigned_feature_ids], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (2, N'61e5a64c-ec29-4854-b2f7-47f607c87e16', N'User', N'4,5,6,7,8', N'', CAST(N'2022-04-16 12:33:59.187' AS DateTime), 1, CAST(N'2022-04-16 12:33:59.187' AS DateTime), 1, NULL, 1)
INSERT [dbo].[UserRole] ([user_role_master_id], [guid], [user_role_name], [assigned_menu_ids], [assigned_feature_ids], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (4, N'a754855e-3ed1-47a8-8f81-92eef8534e87', N'Staff', N'5,15', N'', CAST(N'2022-04-26 17:18:50.910' AS DateTime), 1, CAST(N'2022-04-26 17:18:50.910' AS DateTime), 1, NULL, 1)
INSERT [dbo].[UserRole] ([user_role_master_id], [guid], [user_role_name], [assigned_menu_ids], [assigned_feature_ids], [created_on], [created_by], [modified_on], [modified_by], [user_ip], [is_active]) VALUES (5, N'ee33ffd7-403d-43d2-86d2-441f88893dfa', N'PR Manager', N'8,18', N'', CAST(N'2022-04-27 20:41:02.243' AS DateTime), 1, CAST(N'2022-04-27 20:41:02.243' AS DateTime), 1, NULL, 1)
SET IDENTITY_INSERT [dbo].[UserRole] OFF
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
USE [master]
GO
ALTER DATABASE [softcron] SET  READ_WRITE 
GO
