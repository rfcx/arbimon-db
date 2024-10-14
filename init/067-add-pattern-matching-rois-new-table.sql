create table arbimon2.pattern_matching_rois_new (
    pattern_matching_roi_id   int unsigned auto_increment primary key,
    pattern_matching_id       int not null,
    recording_id              bigint unsigned not null,
    species_id                int not null,
    songtype_id               int not null,
    x1                        float not null,
    y1                        smallint unsigned not null,
    x2                        float not null,
    y2                        smallint unsigned not null,
    uri_param1                mediumint unsigned not null,
    uri_param2                tinyint unsigned null,
    score                     float null,
    validated                 tinyint(1) null,
    cs_val_present            tinyint default 0 not null,
    cs_val_not_present        tinyint default 0 not null,
    consensus_validated       tinyint(1) null,
    expert_validated          tinyint(1) null,
    expert_validation_user_id smallint unsigned null,
    denorm_site_id            int unsigned null,
    denorm_recording_datetime datetime null,
    denorm_recording_date     date null,
    constraint fk_pattern_matching_rois_2
        foreign key (pattern_matching_id) references arbimon2.pattern_matchings (pattern_matching_id),
    constraint fk_pattern_matching_rois_3
        foreign key (recording_id) references arbimon2.recordings (recording_id) on delete cascade,
    constraint fk_pattern_matching_rois_4
        foreign key (species_id) references arbimon2.species (species_id),
    constraint fk_pattern_matching_rois_5
        foreign key (songtype_id) references arbimon2.songtypes (songtype_id),
    constraint fk_pattern_matching_rois_6
        foreign key (denorm_site_id) references arbimon2.sites (site_id)
);
insert into pattern_matching_rois_new
select pattern_matching_roi_id, pattern_matching_id, recording_id, species_id, songtype_id, x1, y1, x2, y2,
       case locate('_', substring_index(uri, '/', -1)) when 0 then cast(substring_index(substring_index(uri, '/', -1), '.', 1) as unsigned) else cast(substring_index(substring_index(uri, '/', -1), '_', 1) as unsigned) end uri_param1,
       case locate('_', substring_index(uri, '/', -1)) when 0 then null else cast(substring_index(substring_index(uri, '_', -1), '.', 1) as unsigned) end uri_param2,
       score, validated, cs_val_present, cs_val_not_present, consensus_validated, expert_validated, expert_validation_user_id,
       denorm_site_id, denorm_recording_datetime, denorm_recording_date
from pattern_matching_rois;
