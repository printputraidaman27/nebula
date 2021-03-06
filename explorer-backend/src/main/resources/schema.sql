
CREATE TABLE `neb_block` (
  `height` bigint(16) unsigned NOT NULL COMMENT 'block height',
  `hash` varchar(64) NOT NULL COMMENT 'hex string of block hash',
  `parent_hash` varchar(64) NOT NULL COMMENT 'hex string of block parent hash',
  `timestamp` datetime NOT NULL COMMENT 'block timestamp',
  `miner` varchar(64) NOT NULL COMMENT 'hex string of miner address',
  `coinbase` varchar(48) NOT NULL COMMENT 'hex string of coinbase address',
  `finality` tinyint(2) NOT NULL DEFAULT '0' COMMENT 'block is irreversible',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`height`),
  UNIQUE KEY `uniq_neb_block_hash` (`hash`),
  KEY `idx_neb_block_miner` (`miner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='nebulas block';

CREATE TABLE `neb_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'primary key, generated by program',
  `hash` varchar(40) NOT NULL DEFAULT '' COMMENT 'hex string of address hash',
  `type` tinyint(2) NOT NULL DEFAULT '0' COMMENT 'address type, 0: Normal; 1: Contract',
  `alias` varchar(256) NOT NULL DEFAULT '' COMMENT 'address alias',
  `current_balance` decimal(50,0) NOT NULL COMMENT 'address current balance',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_neb_address_hash` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='nebulas address';

CREATE TABLE IF NOT EXISTS `neb_dynasty` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `block_height` bigint(16) NOT NULL COMMENT 'block height',
  `delegate` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT 'delegate address',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_blockheiht_delegate` (`block_height`,`delegate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='nebulas dynasty';

CREATE TABLE `neb_transaction` (
  `hash` varchar(64) NOT NULL COMMENT 'hex string of transaction hash',
  `block_hash` varchar(64) NOT NULL COMMENT 'hex string of block hash',
  `block_height` bigint(16) unsigned NOT NULL COMMENT 'block height',
  `tx_seq` int(11) NOT NULL DEFAULT '1' COMMENT 'tx sequence in same block',
  `from` varchar(64) NOT NULL COMMENT 'hex string of the sender account address',
  `to` varchar(64) NOT NULL COMMENT 'hex string of the receiver account address',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT 'transaction status, 0: failed; 1: success; ',
  `value` varchar(64) DEFAULT NULL COMMENT 'value of transaction',
  `nonce` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT 'transaction nonce',
  `timestamp` datetime DEFAULT NULL COMMENT 'transaction timestamp',
  `type` varchar(32) DEFAULT NULL COMMENT 'transaction type, such as: binary',
  `data` text COMMENT 'transaction type, such as: binary???deploy???core???candidate???delegate',
  `gas_price` varchar(64) DEFAULT NULL COMMENT 'Gas price',
  `gas_limit` varchar(64) DEFAULT NULL COMMENT 'Gas limit',
  `gas_used` varchar(64) DEFAULT NULL COMMENT 'Gas used',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`hash`),
  KEY `idx_neb_transaction_from` (`from`),
  KEY `idx_neb_transaction_to` (`to`),
  KEY `idx_blkheight_txseq` (`block_height`,`tx_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='nebulas transaction';

CREATE TABLE `neb_pending_transaction` (
  `hash` varchar(64) NOT NULL COMMENT 'hex string of transaction hash',
  `from` varchar(64) NOT NULL COMMENT 'hex string of the sender account address',
  `to` varchar(64) NOT NULL COMMENT 'hex string of the receiver account address',
  `value` varchar(64) DEFAULT NULL COMMENT 'value of transaction',
  `nonce` bigint(16) unsigned DEFAULT NULL COMMENT 'transaction nonce',
  `timestamp` datetime DEFAULT NULL COMMENT 'transaction timestamp',
  `type` varchar(32) DEFAULT NULL COMMENT 'transaction type, such as: binary???deploy???core???candidate???delegate',
  `data` text COMMENT 'transaction data',
  `gas_price` varchar(64) DEFAULT NULL COMMENT 'Gas price',
  `gas_limit` varchar(64) DEFAULT NULL COMMENT 'Gas limit',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`hash`),
  KEY `idx_neb_transaction_from` (`from`),
  KEY `idx_neb_transaction_to` (`to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='nebulas pending transaction';

CREATE TABLE IF NOT EXISTS `neb_market_capitalization` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `market_cap` decimal(20,2) NOT NULL,
  `volume_24h` decimal(20,2) NOT NULL,
  `change_24h` decimal(5,2) NOT NULL,
  `trends` tinyint(2) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `price_unit` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='nebulas market capitalization';

CREATE TABLE IF NOT EXISTS `block_sync_record` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `block_height` bigint(16) NOT NULL,
  `tx_cnt` bigint(20) NOT NULL,
  `confirm` bigint(16) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_blkheight` (`block_height`),
  KEY `idx_confirm_blkheight` (`confirm`,`block_height`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='block synced record';
