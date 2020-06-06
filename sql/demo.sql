
-- MK FILESYSTEM w/ one root
START TRANSACTION;
-- create revset
SET @unixtime = NOW();
INSERT INTO `generic_object_revset`(`create_timestamp`) values (@unixtime);
set @revset_id = last_insert_id();

-- create filesystem object
INSERT INTO `generic_object`(create_revset_id, current_revset_id, revset_count) values(@revset_id, @revset_id, 1);
SET @fs_object_id = last_insert_id();
-- create rootdir 
INSERT INTO `generic_object`(create_revset_id, current_revset_id, revset_count) values(@revset_id, @revset_id, 1);
SET @rootdir_object_id = last_insert_id();
INSERT INTO `directory_metadata`(object_id, parent_object_id, directory_name, entry_count, first_entry_id) 
values  (@rootdir_object_id, @fs_object_id, '/', 0, NULL);

SET @filesystem_uuid = UUID();
INSERT INTO `filesystem_metadata`(object_id, fs_uuid, version, root_directory_object_id) 
values(@fs_object_id, UuidToBin(@filesystem_uuid), 1, @rootdir_object_id);

COMMIT;


-- SELECT @rootdir_object_id = root_directory_object_id FROM filesystem_metadata LIMIT 1;


-- put file in rootdir
START TRANSACTION;

SELECT @dir_revset_id = current_revset_id, @dir_revset_count = revset_count from generic_object
WHERE id = @rootdir_object_id;

SELECT object_id, parent_object_id, directory_name, @dir_entry_count = entry_count, first_entry_id 
from directory_metadata WHERE object_id = @rootdir_object_id;

-- create revset
SET @unixtime = NOW();
INSERT INTO `generic_object_revset`(`create_timestamp`) values (@unixtime);
set @revset_id = last_insert_id();

-- create file object
SET @dir_revset_count = 1;
INSERT INTO `generic_object`(create_revset_id, current_revset_id, revset_count) values(@revset_id, @revset_id, @dir_revset_count);
SET @file_object_id = last_insert_id();

INSERT INTO file_metadata(object_id, parent_object_id, file_name, file_size_bytes, file_ondisk_offset, file_compression_scheme) 
values(@file_object_id, @rootdir_object_id, 'testfile', 666, 100000, NULL);

UPDATE directory_metadata set entry_count = (@dir_entry_count=@dir_entry_count+1) WHERE object_id = @rootdir_object_id;
UPDATE generic_object SET current_revset_id = @revset_id, revset_count = (@dir_revset_count=@dir_revset_count+1) WHERE id = @rootdir_object_id;

COMMIT;
