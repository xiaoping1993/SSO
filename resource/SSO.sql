USE [SSO]
GO
/****** Object:  Table [dbo].[ApplicationInfo]    Script Date: 2019/12/17 10:20:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationInfo](
	[applicationId] [int] IDENTITY(1,1) NOT NULL,
	[applicationUrl] [varchar](200) NULL,
	[userName] [varchar](50) NULL,
	[passWord] [varchar](50) NULL,
	[des] [varchar](500) NULL,
	[icon] [varchar](50) NULL,
	[applicationName] [varchar](50) NULL,
 CONSTRAINT [PK_ApplicationInfo] PRIMARY KEY CLUSTERED 
(
	[applicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[operateLog]    Script Date: 2019/12/17 10:20:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[operateLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[operateMethod] [varchar](100) NULL,
	[operateUserId] [varchar](100) NULL,
	[operateTime] [datetime] NULL,
	[operateRequest] [varchar](max) NULL,
	[operateResponse] [varchar](max) NULL,
 CONSTRAINT [PK_operateLog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Organization]    Script Date: 2019/12/17 10:20:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organization](
	[organizationId] [int] IDENTITY(1,1) NOT NULL,
	[organizationName] [varchar](50) NULL,
	[organizationDec] [varchar](50) NULL,
 CONSTRAINT [PK_Organization] PRIMARY KEY CLUSTERED 
(
	[organizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_application]    Script Date: 2019/12/17 10:20:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_application](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[applicationId] [int] NULL,
 CONSTRAINT [PK_user_application] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 2019/12/17 10:20:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInfo](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[PassWord] [varchar](50) NOT NULL,
	[OrganizationId] [int] NULL,
	[Des] [varchar](500) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ApplicationInfo] ON 

INSERT [dbo].[ApplicationInfo] ([applicationId], [applicationUrl], [userName], [passWord], [des], [icon], [applicationName]) VALUES (1, N'http://47.103.133.15:8880/EMPI/login', N'admin', N'admin', NULL, N'empi.png', N'EMPI')
INSERT [dbo].[ApplicationInfo] ([applicationId], [applicationUrl], [userName], [passWord], [des], [icon], [applicationName]) VALUES (3, N'http://47.103.133.15:8888/WSManager/login', N'admin', N'admin', NULL, N'spotfire.jpg', N'spotfire')
SET IDENTITY_INSERT [dbo].[ApplicationInfo] OFF
SET IDENTITY_INSERT [dbo].[Organization] ON 

INSERT [dbo].[Organization] ([organizationId], [organizationName], [organizationDec]) VALUES (1, N'RENJI', N'afsdfa')
SET IDENTITY_INSERT [dbo].[Organization] OFF
SET IDENTITY_INSERT [dbo].[user_application] ON 

INSERT [dbo].[user_application] ([id], [userId], [applicationId]) VALUES (1, 1, 1)
INSERT [dbo].[user_application] ([id], [userId], [applicationId]) VALUES (2, 1, 3)
SET IDENTITY_INSERT [dbo].[user_application] OFF
SET IDENTITY_INSERT [dbo].[UserInfo] ON 

INSERT [dbo].[UserInfo] ([UserId], [UserName], [PassWord], [OrganizationId], [Des]) VALUES (1, N'admin', N'2f7a05538e9abc3d', 1, NULL)
INSERT [dbo].[UserInfo] ([UserId], [UserName], [PassWord], [OrganizationId], [Des]) VALUES (3, N'xiaoming', N'4832674d90ee20198d6af96f5a836de5', 1, NULL)
SET IDENTITY_INSERT [dbo].[UserInfo] OFF
ALTER TABLE [dbo].[user_application]  WITH CHECK ADD  CONSTRAINT [FK_user_application_ApplicationInfo] FOREIGN KEY([applicationId])
REFERENCES [dbo].[ApplicationInfo] ([applicationId])
GO
ALTER TABLE [dbo].[user_application] CHECK CONSTRAINT [FK_user_application_ApplicationInfo]
GO
ALTER TABLE [dbo].[user_application]  WITH CHECK ADD  CONSTRAINT [FK_user_application_UserInfo] FOREIGN KEY([userId])
REFERENCES [dbo].[UserInfo] ([UserId])
GO
ALTER TABLE [dbo].[user_application] CHECK CONSTRAINT [FK_user_application_UserInfo]
GO
