
--
-- Table structure for table `session_result`
--

CREATE TABLE `session_result` (
  `id` varchar(36) NOT NULL,
  `name` varchar(512) NOT NULL,
  `nis` varchar(512) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `session_result`
--

INSERT INTO `session_result` (`id`, `name`, `nis`, `date`, `created_at`, `updated_at`, `deleted_at`) VALUES
('4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 'Sindoro Bunyu', '123456', '2026-10-03 09:05:18', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('d44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 'Kongkow', '1236', '2026-10-03 09:06:04', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `session_result_detail`
--

CREATE TABLE `session_result_detail` (
  `id` varchar(36) NOT NULL,
  `session_result_id` varchar(36) NOT NULL,
  `scene` int(11) NOT NULL,
  `part` int(11) NOT NULL,
  `is_passed` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `fluency` int(11) NOT NULL,
  `professionalism` int(11) NOT NULL,
  `intonation` int(11) NOT NULL,
  `content` text NOT NULL,
  `feedback` text NOT NULL,
  `suggested_response` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `session_result_detail`
--

INSERT INTO `session_result_detail` (`id`, `session_result_id`, `scene`, `part`, `is_passed`, `score`, `fluency`, `professionalism`, `intonation`, `content`, `feedback`, `suggested_response`, `created_at`, `updated_at`, `deleted_at`) VALUES
('02061146-876e-4016-a441-4dc7fd7660e9', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 3, 2, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('0e865ba0-34ea-4413-88de-ccc1deab42f6', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 2, 3, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('21f894c4-c218-4b3f-942d-3fae45470b41', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 1, 6, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('238b65f4-b6e1-4654-8a44-b8292a2d429b', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 4, 8, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('2851a50b-ac7b-4d4b-968b-fe74fcb0cd1c', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 1, 2, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('28c632b5-baa8-4456-be4b-e24f77100d9c', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 1, 4, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('2dc5ce2c-d729-495b-abf2-a88ecd66c5bc', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 4, 5, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('2eeebc8a-83cf-4f04-9c2f-5ad41036e14b', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 2, 4, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('310b8e25-5e94-4798-8e43-8f0025883987', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 2, 5, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('3159c27d-abbf-4468-8022-93047c0029e5', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 4, 4, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('38aecadc-f903-49a2-ab3e-583b5d5f8d29', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 1, 3, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('3f4289b2-aa94-4be9-a421-dff310ddcc22', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 4, 7, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('5a098706-09e8-4ab9-991a-cfa5aa7485b7', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 4, 5, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('607bb761-dec2-4e62-9419-fe3bc1e868c3', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 1, 1, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('63ffe926-a9ed-486a-818e-b2cd0e37bb4f', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 4, 3, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('653d2c74-0a18-4d1a-9db5-c1bfcea9221e', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 1, 8, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('6aef406b-e643-401b-890e-263ed5c5c550', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 1, 5, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('7007aab8-0a7c-4fdf-9365-1a555b15badf', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 4, 1, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('702e3029-5ffb-40cf-a4fc-d484644c2b07', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 3, 1, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('735a1e31-8226-4e07-8d79-c5a022b9ec4e', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 2, 2, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('841eb7de-9921-4042-8988-8b60baf94f4d', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 4, 7, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('856cdaea-e18d-4f36-88d5-24f283d7c844', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 1, 2, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('8bee689b-b8c5-4303-8a3e-5590a34f8d97', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 4, 6, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('8f813e50-8318-4264-af7a-9c6fc81c88a7', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 3, 3, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('9050b985-bcc9-436f-a54a-dab500edbc95', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 3, 4, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('95f03110-a631-451f-982e-d4f5801dbcc1', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 1, 8, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('9f90a1b1-0aff-4f60-8bf5-b1e3cf3e4b06', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 3, 5, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('a62ce44d-6b98-4e71-8cf2-574d422ef6ec', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 3, 2, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('a8ffe515-a502-4113-aa6f-f76e3341443c', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 3, 1, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('aad9b2ab-7657-41f1-9fa2-8288324454d6', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 2, 1, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('b5f5f374-9356-4dd8-aed5-bc52b4d97ffc', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 4, 6, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('bc0015e5-0299-487c-9107-286c7f1f0926', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 3, 5, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('bd354e33-516e-4f8e-923e-e47abc530a91', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 3, 4, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('c02de8f4-8b8b-4e29-b42f-caae0541313d', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 1, 5, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('c10febd3-40cd-41b4-99b8-c95ae5d485c5', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 1, 3, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('c5151c0d-9b67-4f08-9685-aa6b2d3e1fd6', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 4, 3, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('c7950240-0138-4bd0-9299-edb336d05cac', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 2, 4, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('c7969e54-f847-411e-a83e-ad2bae2814a5', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 2, 5, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('cd6787ca-6694-4158-94e2-0a5f232ad2c8', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 1, 7, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('cddf2720-6af0-4305-b068-87d2796bb1c4', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 2, 3, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('d019b788-0448-453c-bf56-6b0d607d03cf', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 4, 2, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('d4d23532-aaa2-4fdf-a530-127cfb284cd1', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 2, 2, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('d6e0b61d-a653-4946-841a-1520b6041133', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 1, 4, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('d90accef-5e38-4240-a804-df5f3e074cdb', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 4, 1, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('da1995f6-fa76-4f8c-a5d8-96c1233e7b9e', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 4, 4, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('dddf4bf4-f697-40f1-826a-d94bd13e9259', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 1, 7, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('e1af29bd-04e8-4877-a632-04d9c98d2411', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 4, 2, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('e57a3d1b-b18c-430b-98b2-e524710173e5', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 2, 1, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('f5ce3c89-51c3-48d6-ab83-8f7ad976a3a5', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 4, 8, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('f9574719-cd46-4bff-ba0c-8e36f9c6bf33', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 3, 3, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL),
('f980b9ef-e610-488d-95d0-6a92db8023f6', '4a643ca8-38e2-4ee7-b52f-aa483f397d3a', 1, 1, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:05:18', '2026-10-03 02:05:18', NULL),
('fc65ee2a-37bd-4146-9efd-c03d4d3cda5b', 'd44f3d8d-18ba-48f8-8a3a-a9f0a7b9d14a', 1, 6, 0, 0, 0, 0, 0, '', '', '', '2026-10-03 02:06:04', '2026-10-03 02:06:04', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` varchar(36) NOT NULL,
  `username` varchar(512) NOT NULL,
  `password` varchar(512) NOT NULL,
  `name` varchar(512) NOT NULL,
  `email` varchar(512) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`, `email`, `created_at`, `updated_at`, `deleted_at`) VALUES
('3509cf38-bd7a-11f1-ac0e-00e01d0321f5', 'admin', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'The Admin', 'admin@me.com', '2026-10-01 09:26:39', '2026-10-01 09:26:39', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `session_result`
--
ALTER TABLE `session_result`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `session_result_detail`
--
ALTER TABLE `session_result_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
