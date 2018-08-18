# rails_distributed_tracing
Distributed tracing for rails microservices

[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=102)](https://opensource.org/licenses/MIT)
[![Gem Version](https://badge.fury.io/rb/rails_distributed_tracing.svg)](https://badge.fury.io/rb/rails_distributed_tracing)
![Gem Downloads](http://ruby-gem-downloads-badge.herokuapp.com/rails_distributed_tracing?type=total)
[![Build Status](https://travis-ci.org/ajitsing/rails_distributed_tracing.svg?branch=master)](https://travis-ci.org/ajitsing/rails_distributed_tracing)
[![Twitter Follow](https://img.shields.io/twitter/follow/Ajit5ingh.svg?style=social)](https://twitter.com/Ajit5ingh)

## Installation
Add this line to all your microservices:
```ruby
gem 'rails_distributed_tracing'
```

## Configuration
Add request id tag to log tags in `application.rb`. This config will make sure that the logs are tagged with a request id.
If the service is origin service, `DistributedTracing.request_id_tag` will create a new request id else it will reuse the request id passed from the origin service.

```ruby
require 'rails_distributed_tracing'

class Application < Rails::Application
  config.log_tags = [DistributedTracing.request_id_tag]
end
```

## Passing request id tag to downstream services
To make the distributed tracing work every service has to the request id to all its downstream services. 
For example lets assume that we have 3 services:   
`OriginService`, `SecondService` and `ThirdService` .  

Now a request comes to `OriginService`, the above config will create a new request_id for that request.
When `OriginService` makes a request to `SecondService` it should pass the same requst_id to it,
so that the request can be traced. The same should happen when `SecondService` calls the `ThirdService`.   

The bottomline is whenever there is a communication between two services, 
source service should always pass the request id to the destination service.

## How to pass request id tag to downstream services
When a request id is generated `rails_distributed_tracing` holds that request id till the request returns the response. You can access that request_id anywhere in your application code with the help of below APIs.

```ruby
DistributedTracing.current_request_id
```

or you can directly get it as a request header

```ruby
DistributedTracing.request_id_header
#=> {'Request-ID' => '8ed7e37b-94e8-4875-afb4-6b4cf1783817'}
```

The gem will automatically pick the `Request-ID` header from your request and use it as log tag.

Note: Make sure that you always pass the current request id and not the stale one.