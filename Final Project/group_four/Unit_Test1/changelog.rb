dir = File.dirname(__FILE__)
require "time"
require "socket"
load dir + "/revlog.rb"
# require "./mdiff"
# require "binascii"
#

# Logical line of the code
=begin
extract: given text (string in binary), parse the manifest(string in hex), user, date, files, desc
addchangeset: get user and combine other informations to a string
addchangeset:
=end

class Changelog < Revlog
    def initialize(repo)
        @repo = repo
        super("00changelog.i", "00changelog.d")
    end

    def open(file, mode="r", &block)
        return @repo.open(file, mode, &block)
    end

    def extract(text)
        l = Mdiff.linesplit(text)
        # TODO: change unpack (unpack is just for debug)
        # haxilify
        manifest = [l[0][0...-1]].pack('H*')
        user = l[1][0...-1]
        date = l[2][0...-1]
        last = l.index("\n")
        files = l[3...last].inject([]) {|mem, f| mem << f[0...-1]}
        desc = l[last+1..-1].inject('') {|mem, s| mem += s}
        return [manifest, user, date, files, desc]
    end


    def changeset(rev)
        # p rev
        return self.extract(self.revision(rev))
    end

    def addchangeset(manifest, list, desc, p1=nil, p2=nil)
        # Problem : getfqdn ?? os.environ ??
        if ! ENV["HGUSER"].nil?
            user = ENV["HGUSER"]
        else
            user = ENV["LOGNAME"] + '@' + Socket.gethostbyname(Socket.gethostname).first
        end
        date = Time.now.getutc.to_i.to_s + " " + Time.now.gmt_offset.to_s
        list = list.sort()
        # unhaxilify
        l = [manifest.unpack('H*').first, user, date]
        l +=  list + ['', desc]
        text = l.inject("") {|mem, e| mem += (e + "\n") }
        # p 'test', text[0..-3]
        return self.addrevision(text, p1, p2)
    end


    def merge3(my, other, base)
    end
end

