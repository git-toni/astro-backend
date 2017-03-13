# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


def create_users
  User.destroy_all
  User.create([
    {name: 'Green Orange',email:'user1@test.com',password:'3333'},
    {name: 'Blue Apple',email:'user2@test.com',password:'3333'},
    {name: 'Purple Banana',email:'user3@test.com',password:'3333'},
  ])
end
def create_telescopes
  Telescope.create([
    {name: 'GALEX',regime:'Low Earth',operator:'NASA', cospar_id:'2003-017A'},
    {name: 'Spitzer',regime:'Earth-trailing',operator:'NASA', cospar_id:'2003-038A'},
    {name: 'Hubble',regime:'Low Earth',operator:'NASA', cospar_id:'1990-037B'},
    {name: 'Chandra',regime:'Highly elliptical',operator:'NASA', cospar_id:'1999-040B'},
  ])
end
def create_posts
  chandra = Telescope.where(name:'Chandra').first
  galex = Telescope.where(name:'GALEX').first
  spitzer = Telescope.where(name:'Spitzer').first
  hubble = Telescope.where(name:'Hubble').first

  galex.posts.create([
    {description: 'GALEX spotted an amazingly long comet-like tail behind the star Mira which is streaking through space at supersonic speeds.',image_url:'https://smd-prod.s3.amazonaws.com/science-red/s3fs-public/styles/large/public/mnt/medialibrary/2011/08/02/star-mira-with-tail_.jpg'},
  ])

  chandra.posts.create([
    {description: "This Chandra image gives the first clear view of the faint boundary of the Crab Nebula's X-ray-emitting pulsar wind nebula. The nebula is powered by a rapidly rotating, highly magnetized neutron star or pulsar.",image_url:'https://smd-prod.s3.amazonaws.com/science-red/s3fs-public/styles/large/public/mnt/medialibrary/2011/08/15/crab-nebula.jpg'},
    {description: "This Chandra image of the galaxy Centaurus A provides one of the best views to date of the effects of an active supermassive black hole. Opposing jets of high-energy particles can be seen extending to the outer reaches of the galaxy",image_url:'https://smd-prod.s3.amazonaws.com/science-red/s3fs-public/styles/large/public/mnt/medialibrary/2011/08/15/centaurus-a-jet-with-black-hole.jpg?itok=L3_8S0-V'},
    {description: "One of the most complicated and dramatic collisions between galaxy clusters ever seen is captured in this composite image from Chandra, Hubble and two ground telescopes",image_url:'https://smd-prod.s3.amazonaws.com/science-red/s3fs-public/styles/large/public/mnt/medialibrary/2011/08/15/abell-2744-galaxy-clusters-collide.jpg?itok=PyNPtFds'},
  ])

  spitzer.posts.create([
    {description: "This is a Spitzer image of the Helix Nebula, a cosmic starlet often photographed by amateur astronomers for its vivid colors and eerie resemblance to a giant eye.",image_url:'https://smd-prod.s3.amazonaws.com/science-red/s3fs-public/styles/large/public/mnt/medialibrary/2011/08/02/the-helix-nebula_.jpg?itok=eWoXVIVj'},
    {description: "Generations of stars can be seen in this new portrait from Spitzer. This image provides some of the best evidence yet for the triggered star-formation theory.",image_url:'https://smd-prod.s3.amazonaws.com/science-red/s3fs-public/styles/large/public/mnt/medialibrary/2011/08/15/w5-star-formation-region.jpg?itok=g4JwvRAo'},
    {description: "A growing galactic metropolis is the most distant known massive proto-cluster of galaxies. The cluster was discovered by a suite of multi-wavelength telescopes including Spitzer, Chandra, Hubble and 2 ground telescopes",image_url:'https://smd-prod.s3.amazonaws.com/science-red/s3fs-public/styles/large/public/mnt/medialibrary/2011/08/15/proto-cluster-of-galaxies-cosmos-axtec3.jpg?itok=6M94ZlRk'},
  ])

  hubble.posts.create([
    {description: "These dainty butterfly wings were captured by Hubble. They are actually roiling cauldrons of gas, which are tearing across space at more than 600,000 miles per hour.",image_url:'https://smd-prod.s3.amazonaws.com/science-red/s3fs-public/styles/large/public/mnt/medialibrary/2011/08/15/the-butterfly-nebula.jpg?itok=wChxGZgk'},
    {description: "Imaged by Hubble this pillar is composed of gas and dust. It resides in a stellar nursery called the Carina Nebula. Scorching radiation and fast winds from these stars are sculpting the pillar and causing new stars to form within it.",image_url:'https://smd-prod.s3.amazonaws.com/science-red/s3fs-public/styles/large/public/mnt/medialibrary/2011/08/15/pillar-in-the-carina-nebula.jpg?itok=wsIAfYnQ'},
    {description: "Thousands of sparkling young stars are nestled in this Hubble image of the giant nebula NGC 3603. The image reveals stages in the life cycle of stars.",image_url:'https://smd-prod.s3.amazonaws.com/science-red/s3fs-public/styles/large/public/mnt/medialibrary/2011/08/15/star-cluster-in-nebula-ngc-3603.jpg?itok=7J28aoiL'},
    {description: "Hubble uncovers a population of infant stars in the Small Magellanic Cloud, a companion galaxy of our Milky Way. The stars have not yet ignited their hydrogen fuel to sustain nuclear fusion",image_url:'https://smd-prod.s3.amazonaws.com/science-red/s3fs-public/styles/large/public/mnt/medialibrary/2011/08/15/infant-stars-in-small-magellanic-cloud.jpg?itok=ZdClcm4e'},
    {description: "This Hubble image of galaxy NGC 4710 is tilted nearly edge-on to our view from Earth. This perspective allows astronomers to easily distinguish the central bulge of stars from its pancake-flat disk of stars, dust, and gas.",image_url:'https://smd-prod.s3.amazonaws.com/science-red/s3fs-public/styles/large/public/mnt/medialibrary/2011/08/15/galaxy-ngc-4710.jpg?itok=JksJw0i7'},
  ])
end

create_users
create_telescopes
create_posts
