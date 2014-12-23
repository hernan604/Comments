use utf8;
package Comment::DB::Result::Url;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Comment::DB::Result::Url

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<url>

=cut

__PACKAGE__->table("url");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cmt_id_seq'

=head2 url

  data_type: 'text'
  is_nullable: 1

=head2 created

  data_type: 'timestamp with time zone'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cmt_id_seq",
  },
  "url",
  { data_type => "text", is_nullable => 1 },
  "created",
  { data_type => "timestamp with time zone", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 comments

Type: has_many

Related object: L<Comment::DB::Result::Comment>

=cut

__PACKAGE__->has_many(
  "comments",
  "Comment::DB::Result::Comment",
  { "foreign.url_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-10-09 15:16:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:BnknYCfSOEyLG8ycEIPOHQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
