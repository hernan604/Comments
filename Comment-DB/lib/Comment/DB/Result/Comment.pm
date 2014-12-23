use utf8;
package Comment::DB::Result::Comment;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Comment::DB::Result::Comment

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<comment>

=cut

__PACKAGE__->table("comment");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'comment_id_seq'

=head2 login_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 comment_id

  data_type: 'integer'
  is_nullable: 1

=head2 comment

  data_type: 'text'
  is_nullable: 1

=head2 url_id

  data_type: 'integer'
  is_foreign_key: 1
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
    sequence          => "comment_id_seq",
  },
  "login_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "comment_id",
  { data_type => "integer", is_nullable => 1 },
  "comment",
  { data_type => "text", is_nullable => 1 },
  "url_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
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

=head2 login

Type: belongs_to

Related object: L<Comment::DB::Result::Login>

=cut

__PACKAGE__->belongs_to(
  "login",
  "Comment::DB::Result::Login",
  { id => "login_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 url

Type: belongs_to

Related object: L<Comment::DB::Result::Url>

=cut

__PACKAGE__->belongs_to(
  "url",
  "Comment::DB::Result::Url",
  { id => "url_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-10-09 15:16:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+94D3eZcrx1suHwtC7yESA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
