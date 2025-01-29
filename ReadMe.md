# EnergyNet: Decentralized Energy Trading Platform

A blockchain-powered platform enabling peer-to-peer trading of renewable energy between homeowners, businesses, and the grid through smart contracts and IoT integration.

## Overview

EnergyNet revolutionizes energy distribution by creating a decentralized marketplace where prosumers can trade excess renewable energy directly with consumers. The platform leverages smart meters, blockchain technology, and automated trading mechanisms to enable efficient, transparent energy trading.

## Core Features

### Energy Trading
- Real-time energy matching
- Dynamic pricing
- Automated settlements
- Grid balancing
- Demand response management

### Production Management
- Solar production tracking
- Wind generation monitoring
- Storage management
- Consumption analytics
- Grid export tracking

### Smart Grid Integration
- Grid stability monitoring
- Load balancing
- Peak demand management
- Frequency regulation
- Voltage optimization

## Technical Architecture

### Smart Contracts
- `EnergyTrade.sol`: Manages energy transactions
- `GridBalance.sol`: Handles grid stability
- `MeterReading.sol`: Processes consumption data
- `AchievementNFT.sol`: Issues energy milestones
- `Settlement.sol`: Handles payments

### IoT Infrastructure
- Smart meters
- Solar inverters
- Battery systems
- Home energy displays
- Grid sensors

### Backend Services
- Node.js/Express API
- TimescaleDB for energy data
- MongoDB for user profiles
- Redis for real-time trading
- RabbitMQ for event handling

### Frontend Applications
- Trading dashboard
- Mobile energy app
- Grid operator interface
- Analytics platform
- Admin portal

## Implementation Guide

### Prerequisites
```bash
node >= 16.0.0
npm >= 8.0.0
docker >= 20.0.0
truffle >= 5.0.0
```

### Installation
1. Clone the repository:
```bash
git clone https://github.com/your-org/energy-net.git
cd energy-net
```

2. Install dependencies:
```bash
npm install
```

3. Configure environment:
```bash
cp .env.example .env
# Update environment variables
```

4. Deploy services:
```bash
docker-compose up -d
npm run start:services
```

## API Documentation

### Energy Trading
```
POST /api/v1/trades/offer
GET /api/v1/trades/available
PUT /api/v1/trades/execute
GET /api/v1/trades/history
```

### Production Monitoring
```
GET /api/v1/production/current
POST /api/v1/production/forecast
GET /api/v1/production/history
GET /api/v1/production/analytics
```

### Grid Management
```
GET /api/v1/grid/status
POST /api/v1/grid/balance
PUT /api/v1/grid/demand
GET /api/v1/grid/stability
```

## Smart Contract Interfaces

### Energy Trading
```solidity
interface IEnergyTrade {
    function createOffer(
        uint256 amount,
        uint256 price,
        uint256 duration,
        bool isSelling
    ) external returns (uint256 offerId);

    function executeTrade(
        uint256 offerId,
        uint256 amount
    ) external returns (bool);
}
```

### Grid Management
```solidity
interface IGridBalance {
    function updateStatus(
        uint256 frequency,
        uint256 voltage,
        uint256 demand,
        uint256 supply
    ) external returns (bool);

    function requestDemandResponse(
        uint256 reduction,
        uint256 duration,
        uint256 compensation
    ) external returns (uint256 requestId);
}
```

## Data Models

### Energy Trade
```json
{
  "tradeId": "string",
  "seller": "address",
  "buyer": "address",
  "amount": "number",
  "price": "number",
  "timestamp": "date",
  "status": "string",
  "gridMetrics": {
    "frequency": "number",
    "voltage": "number",
    "stability": "number"
  }
}
```

## Trading Mechanics

### Order Types
- Immediate execution
- Time-based orders
- Price-limited orders
- Grid-balanced orders
- Conditional orders

### Price Discovery
- Real-time matching
- Dynamic pricing
- Grid demand factors
- Time-of-use rates
- Peak pricing

## Grid Integration

### Stability Management
- Frequency monitoring
- Voltage regulation
- Demand prediction
- Supply balancing
- Emergency response

### Smart Meter Integration
- Real-time readings
- Two-way communication
- Consumption profiling
- Export monitoring
- Tamper detection

## Security Features

### System Security
- Smart meter encryption
- Blockchain security
- Access control
- Data protection
- Fraud prevention

### Grid Security
- Attack prevention
- Failure detection
- Backup systems
- Emergency protocols
- Recovery procedures

## Analytics & Reporting

### Performance Metrics
- Trading volume
- Grid stability
- Energy savings
- Carbon reduction
- System efficiency

### Reporting Tools
- Real-time dashboard
- Historical analysis
- Forecasting tools
- Efficiency reports
- Environmental impact

## User Features

### Prosumer Tools
- Production monitoring
- Trading interface
- Revenue tracking
- Efficiency analysis
- Storage management

### Consumer Tools
- Consumption tracking
- Cost optimization
- Supplier selection
- Payment management
- Usage analytics

## Support & Resources

- Documentation: https://docs.energynet.io
- API Reference: https://api.energynet.io/docs
- Support Portal: support.energynet.io
- Community Forum: forum.energynet.io

## License

Licensed under Apache 2.0 - see [LICENSE](LICENSE) for details.
